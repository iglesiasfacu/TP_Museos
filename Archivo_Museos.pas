unit Archivo_Museos;

interface

uses crt, Archivo_Directores;

type

	st30=string[30];

	R_Museos=record
		Cod_Museo:integer;
		Nom_Museo:st30;
		Direc_Museo:st30;
		Ciudad_Museo:st30;
		Pais_Museo:st30;
		Tel_Museo:longint;
		DNI_Direc:integer;
		Estado_Museo:Boolean;
		end;
	
	T_Museos = file of R_Museos;
	
	procedure Abrir_Museo(var Arch:T_Museos; Nom_Arch:string);
	procedure Leer_Museo(var Arch:T_Museos; Nom_Arch:string; var Pos:integer; var Leer_Dato:R_Museos);
	procedure Guardar_Museo(var Arch:T_Museos; Nom_Arch:string; var Escribir_Dato:R_Museos);
	procedure Modificar_Museo(var Arch:T_Museos; var Arch_Dir:T_Directores; Nom_Arch:string; Nom_Arch_Dir:string; Pos:integer);
	procedure Alta_Museo(var Arch:T_Museos; var Arch_Dir:T_Directores; Nom_Arch:string; Nom_Arch_Dir:string ;var Reg:R_Museos);
	procedure Baja_Museo(var Arch:T_Museos; Nom_Arch:string; var Pos:integer);
	procedure Alta_Estado_Museo(var Arch:T_Museos; Nom_Arch:string; var Pos:integer);
	procedure Eliminar_Museo(var Arch:T_Museos);
	procedure Busqueda_Nombre_Museo(var Arch:T_Museos; Nom_Arch:string; Busc:st30; var Pos:integer);
	procedure Busqueda_Codigo_Museo(var Arch:T_Museos; Nom_Arch:string; Busc:integer; var Pos:integer);
	procedure Busqueda_DNI_Director_Museo(var Arch:T_Museos; Nom_Arch:string; Busc:integer; var Pos:integer);


implementation

procedure Abrir_Museo(var Arch:T_Museos; Nom_Arch:string);
	begin
		assign(Arch, Nom_Arch);
		{$I-}                
			reset(Arch);
		{$I-}
		if ioresult <> 0 then
			rewrite(Arch);
	end;

procedure Leer_Museo(var Arch:T_Museos; Nom_Arch:string; var Pos:integer; var Leer_Dato:R_Museos); 
	begin
		Abrir_Museo(Arch, Nom_Arch);
		seek(Arch, Pos);
		read(Arch, Leer_Dato);  
		close(Arch);
	end;

procedure Guardar_Museo(var Arch:T_Museos; Nom_Arch:string; var Escribir_Dato:R_Museos);
	var
		Reg:R_Museos;
		Pos:integer;
	begin
		Pos:=0;
		Leer_Museo(Arch, Nom_Arch, Pos, Reg);
		Abrir_Museo(Arch, Nom_Arch);
		seek(Arch, filesize(Arch));
		if filepos(Arch) = 1 then
			begin
				if Reg.Cod_Museo = 0 then
					begin
						seek(Arch, 0);
						write(Arch, Escribir_Dato);  
					end
				else
					begin
						seek(Arch, filesize(Arch));
						write(Arch, Escribir_Dato);
					end;
			end
		else
			 begin
				   seek(Arch, filesize(Arch));
				   write(Arch, Escribir_Dato);
			 end;
		close(Arch);
	end;

procedure Modificar_Museo(var Arch:T_Museos; var Arch_Dir:T_Directores; Nom_Arch:string; Nom_Arch_Dir:string; Pos:integer);
	var
		Reg:R_Museos;
		Control:char;
		Val,x,y,i:integer;
		Posi:integer;
	begin
		clrscr;
		Leer_Museo(Arch, Nom_Arch, Pos, Reg);
		if Reg.Estado_Museo then
	    begin
	    clrscr;
	    textcolor(6);
		x:=3;
		y:=4;
		for i := 1 to 18 do
		begin
			gotoxy(x,y);
			writeln('|');
			inc(y);
		end;
		x:=54;
		y:=4;
		for i := 1 to 14 do
		begin
			gotoxy(x,y);
			writeln('|');
			inc(y);
		end;
		x:=4;
		y:=17;
		for i := 1 to 38 do
		begin
			gotoxy(x,y);
			writeln('_');
			x:=x+2
		end;
		x:=4;
		y:=21;
		for i := 1 to 38 do
		begin
			gotoxy(x,y);
			writeln('_');
			x:=x+2
		end;
		x:=79;
		y:=4;
		for i := 1 to 18 do
		begin
			gotoxy(x,y);
			writeln('|');
			inc(y);
		end;
		x:=4;
		y:=3;
		for i := 1 to 38 do
		begin
			gotoxy(x,y);
			writeln('_');
			x:=x+2
		end;
		textcolor (white);
		gotoxy(5,8);
		writeln('Nombre del museo: ', Reg.Nom_Museo);
		gotoxy(5,9);
		writeln('DNI del director: ', Reg.DNI_Direc);
		gotoxy(5,10);
		writeln('Direccion: ', Reg.Direc_Museo);
		gotoxy(5,11);
		writeln('Ciudad: ', Reg.Ciudad_Museo);
		gotoxy(5,12);
		writeln('Pais: ', Reg.Pais_Museo);
		gotoxy(5,13);
		writeln('Telefono: ', Reg.Tel_Museo);
		gotoxy(5,19);
	    writeln(' Ingrese: ');
	    textbackground(white);
	    textcolor(128);	
		gotoxy(56,6);
		writeln('Que desea modificar?');
		textbackground(black);
	    textcolor(white);	
		gotoxy(56,8);
		writeln('1) Nombre del museo: ');
		gotoxy(56,9);
		writeln('2) DNI del director: ');
		gotoxy(56,10);
		writeln('3) Direccion: ');
		gotoxy(56,11);
		writeln('4) Ciudad: ');
		gotoxy(56,12);
		writeln('5) Pais: ');
		gotoxy(56,13);
		writeln('6) Telefono: ');
		gotoxy(56,14);
		writeln('ESC) Salir');
		repeat
			 gotoxy(10,20);
			 writeln('                                                                  ');
			 Control:=readkey;
			 keypressed;
			 case Control of
				  '1':begin
						   gotoxy(15,19);
						   readln(Reg.Nom_Museo);
						   gotoxy(15,19);
						   writeln('                                                   ');
						   gotoxy(23,8);
						   writeln('                             ');
						   gotoxy(23,8);
						   writeln(Reg.Nom_Museo);
						   Reg.Estado_Museo:=true;
						   Abrir_Museo(Arch, Nom_Arch);
						   seek(Arch, Pos);
						   write(Arch, Reg);
						   close(Arch);
					   end;
				   '2':begin
							repeat
								  gotoxy(10,20);
								  writeln('                                                          ');
							      gotoxy(15,19);
							      writeln('                                                           ');
								  gotoxy(15,19);
								  {$I-}
									   readln(Reg.DNI_Direc);
								  {$I+}
								  Val:=ioresult();
								  if Val<>0 then
									 begin
										  gotoxy(15,19);
										  writeln('                                                               ');
										  gotoxy(10,20);
										  writeln('                                                                 ');
										  gotoxy(10,20);
										  textcolor(red);
										  writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
										  textcolor(white);
										  readkey;
									 end;
							until Val=0;
							Busqueda_DNI_Director(Arch_Dir, Nom_Arch_Dir, Reg.DNI_Direc, Posi);
							if Posi>-1 then
							   begin
									gotoxy(15,19);
									writeln('                                                              ');
									gotoxy(23,9);
									writeln('                        ');
									gotoxy(23,9);
									writeln(Reg.DNI_Direc);
									Abrir_Museo(Arch, Nom_Arch);
									seek(Arch, Pos);
									write(Arch, Reg);
									close(Arch);
							   end
							else
								begin
									gotoxy(15,19);
									writeln('                                                                  ');
									gotoxy(10,20);
									writeln('                                                                     ');
									gotoxy(10,20);
									textcolor(red);
									writeln(#7'El director no esta registrado. Dar de alta para continuar.');
									textcolor(white);
									readkey;
								end;
					   end;
				   '3':begin
							gotoxy(15,19);
							readln(Reg.Direc_Museo);
							gotoxy(15,19);
							writeln('                                                ');
							gotoxy(16,10);
							writeln('                                  ');
							gotoxy(16,10);
							writeln(Reg.Direc_Museo);
							Reg.Estado_Museo:=true;
							Abrir_Museo(Arch, Nom_Arch);
							seek(Arch, Pos);
							write(Arch, Reg);
							close(Arch);
					   end;
				   '4':begin
							gotoxy(15,19);
							readln(Reg.Ciudad_Museo);
							gotoxy(15,19);
							writeln('                                                ');
							gotoxy(13,11);
							writeln('                               ');
							gotoxy(13,11);
							writeln(Reg.Ciudad_Museo);
							Reg.Estado_Museo:=true;
							Abrir_Museo(Arch, Nom_Arch);
							seek(Arch, Pos);
							write(Arch, Reg);
							close(Arch);
					   end;
				   '5':begin
							gotoxy(15,19);
							readln(Reg.Pais_Museo);
							gotoxy(15,19);
							writeln('                                      ');
							gotoxy(11,12);
							writeln('                               ');
							gotoxy(11,12);
							writeln(Reg.Pais_Museo);
							Reg.Estado_Museo:=true;
							Abrir_Museo(Arch, Nom_Arch);
							seek(Arch, Pos);
							write(Arch, Reg);
							close(Arch);
					   end;
				   '6':begin
							repeat
								  gotoxy(10,20);
								  writeln('                                                          ');
								  gotoxy(15,19);
								  writeln('                                                         ');
								  gotoxy(15,19);
								  {$I-}
									   readln(Reg.Tel_Museo);
								  {$I+}
								  Val:=ioresult();
								  if Val <> 0 then
								  begin
									   gotoxy(10,20);
									   writeln('                                                                 ');
									   gotoxy(10,20);
									   textcolor(red);
									   writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
									   textcolor(white);
									   readkey;
								  end;
							 until Val=0;
							 gotoxy(15,19);
							 writeln('                                                         ');
							 gotoxy(15,13);
							 writeln('                                ');
							 gotoxy(15,13);
							 writeln(Reg.Tel_Museo);
							 Reg.Estado_Museo:=true;
							 Abrir_Museo(Arch, Nom_Arch);
							 seek(Arch, Pos);
							 write(Arch, Reg);
							 close(Arch);
					   end;
			 end;
		until control=#27;
		end
		  else
			  begin
				   textcolor(red);
				   gotoxy(15,10);
				   writeln('                                               ');
				   gotoxy(15,10);
				   writeln('El museo esta dado de baja. Dar de alta para continuar.');
				   textcolor(white);
				   readkey;
			  end;
		end;


procedure Alta_Museo(var Arch:T_Museos; var Arch_Dir:T_Directores; Nom_Arch:string; Nom_Arch_Dir:string ;var Reg:R_Museos);
	var
		Val,Posi,x,y,i:integer;
		Control:char;
		Clave:string;
		Reg_Dir:R_Directores;
		Ultima_Pos:integer;
		Reg_Mus2:R_Museos;
	begin
	Abrir_Museo(Arch, Nom_Arch); 
	if filesize(Arch)=0 then    
	begin                
		Reg.Cod_Museo:=0;  // inicia codigo museo en 0
		seek(Arch,0);
		write(Arch, Reg);       
	end;                        
	close(Arch);              
	clrscr;
	textcolor(6);
	x:=12;
	y:=2;
	for i:=1 to 18 do // izq
		begin
			gotoxy(x,y);
			writeln('*');
			inc(y);
		end;
	x:=12;
	y:=2;
	for i:=1 to 30 do // arriba
		begin
			gotoxy(x,y);
			writeln('*');
			x:=x+2
		end;
	x:=70;
	y:=2;
	for i:=1 to 18 do // der
		begin
			gotoxy(x,y);
			writeln('*');
			inc(y);
		end;
	x:=12;
	y:=20;
	for i:=1 to 30 do // abajo
		begin
			gotoxy(x,y);
			writeln('*');
			x:=x+2
		end;
	textcolor(white);
	Posi:=-1;
	gotoxy(15,3);
	writeln('ALTA DE MUSEO');
	gotoxy(20,6);
	writeln('Nombre: ');
	gotoxy(20,8);
	writeln('DNI del Director: ');
	gotoxy(20,10);
	writeln('Direccion: ');
	gotoxy(20,12);
	writeln('Ciudad: ');
	gotoxy(20,14);
	writeln('Pais: ');
	gotoxy(20,16);
	writeln('Telefono: ');
	gotoxy(20,18);
	writeln('Codigo: ');
	gotoxy(28,6);
	readln(Clave);
	Abrir_Museo(Arch, Nom_Arch); 
	Ultima_Pos:=filesize(Arch)-1;  // lee ultima pos del registro
	close(Arch);        
	Leer_Museo(Arch, Nom_Arch, Ultima_Pos, Reg_Mus2);
	Reg.Cod_Museo:=Reg_Mus2.Cod_Museo+1;      // genera codigo automaticamente
	gotoxy(28,18);
	writeln(Reg.Cod_Museo);
	Busqueda_Nombre_Museo(Arch, Nom_Arch, Clave, Posi);
	if Posi = -1 then
	  begin
		   Reg.Nom_Museo:=Clave;
		   repeat
				 gotoxy(38,8);
				 writeln('                              ');
				 gotoxy(38,8);
				 {$I-}
					  readln(Reg.DNI_Direc);
				 {$I+}
				 Val:=ioresult();
				 if Val<>0 then
					begin
						 gotoxy(20,22);
						 textcolor(red);
						 writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
						 textcolor(white);
					end;
		   until Val=0;
		   gotoxy(15,22);
		   writeln('                                                         ');
		   Busqueda_DNI_Director(Arch_Dir, Nom_Arch_Dir, Reg.DNI_Direc, Posi);
		   if Posi>-1 then
			  begin
				   Leer_Director(Arch_Dir, Nom_Arch_Dir, Posi, Reg_Dir);
				   if Reg_Dir.Estado_Dir then
					  begin
						   gotoxy(31,10);
						   readln(Reg.Direc_Museo);
						   gotoxy(28,12);
						   readln(Reg.Ciudad_Museo);
						   gotoxy(26,14);
						   readln(Reg.Pais_Museo);
						   repeat
								 gotoxy(30,16);
								 writeln('                                     ');
								 gotoxy(30,16);
								 {$I-}
									  readln(Reg.Tel_Museo);
								 {$I+}
								 Val:=ioresult();
								 if Val <> 0 then
									begin
										 gotoxy(20,22);
										 textcolor(red);
										 writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
										 textcolor(white);
									end;
						   until Val=0;
						   gotoxy(20,22);
						   writeln('                                                              ');
						   Reg.Estado_Museo:=true;
						   Guardar_Museo(Arch, Nom_Arch, Reg);
						   gotoxy(25,22);
						   textcolor(green);
						   writeln('El museo ha sido dado de alta.');
						   textcolor(white);
						   readkey;
					  end
						 else
							 begin
								  gotoxy(5,22);
								  textcolor(red);
								  writeln(#7'El director esta registrado pero dado de baja. Dar de alta para continuar.');
								  textcolor(white);
								  readkey;
							 end;
			  end
				 else
					 begin
						  gotoxy(5,22);
						  textcolor(red);
						  writeln(#7'El director del museo no esta registrado. Dar de alta para continuar.');
						  textcolor(white);
						  readkey;
					 end;
	  end
		 else
			 begin
				  Leer_Museo(Arch, Nom_Arch, Posi, Reg);
				  if (Reg.Estado_Museo) then
					 begin
						  repeat
						  	clrscr;
							textcolor(6);
							x:=12;
							y:=2;
							for i:=1 to 18 do // izq
								begin
									gotoxy(x,y);
									writeln('*');
									inc(y);
								end;
							x:=12;
							y:=2;
							for i:=1 to 30 do // arriba
								begin
									gotoxy(x,y);
									writeln('*');
									x:=x+2
								end;
							x:=70;
							y:=2;
							for i:=1 to 18 do // der
								begin
									gotoxy(x,y);
									writeln('*');
									inc(y);
								end;
							x:=12;
							y:=20;
							for i:=1 to 30 do // abajo
								begin
									gotoxy(x,y);
									writeln('*');
									x:=x+2
								end;
								textcolor(white);
								gotoxy(17,6);
								writeln('Esta museo ya esta registrado. Que desea hacer?');
								gotoxy(34,10);
								writeln('1) Modificar');
								gotoxy(34,12);
								writeln('2) Dar de baja');
								gotoxy(34,14);
								writeln('ESC) Volver');
								Control:=readkey;
								keypressed;
								if (Control = '1') then
								   Modificar_Museo(Arch, Arch_Dir, Nom_Arch, Nom_Arch_Dir ,Posi)
									  else
										  if (Control='2') then
											 begin
												  Baja_Museo(Arch, Nom_Arch, Posi);
												  gotoxy(25,22);
												  textcolor(green);
												  writeln('El museo ha sido dado de baja');
												  textcolor(white);
												  readkey;
											 end
											 else
												 if (Control=#27) then
													clrscr
													   else
														   begin

																gotoxy(20,22);
																Textcolor(red);
																writeln(#7'Tecla no válida. Vuelva a intentar.');
																Textcolor(white);
																readkey;
														   end;
						  until (Control = '1') or (Control='2') or (Control = #27);
					 end
					 else
						 begin
							  repeat
										clrscr;
										textcolor(6);
										x:=12;
										y:=2;
										for i:=1 to 18 do // izq
											begin
												gotoxy(x,y);
												writeln('*');
												inc(y);
											end;
										x:=12;
										y:=2;
										for i:=1 to 30 do // arriba
											begin
												gotoxy(x,y);
												writeln('*');
												x:=x+2
											end;
										x:=70;
										y:=2;
										for i:=1 to 18 do // der
											begin
												gotoxy(x,y);
												writeln('*');
												inc(y);
											end;
										x:=12;
										y:=20;
										for i:=1 to 30 do // abajo
											begin
												gotoxy(x,y);
												writeln('*');
												x:=x+2
											end;
									textcolor(red);
									gotoxy(16,6);
									writeln('Este museo esta registrado pero dado de baja');
									textcolor(white);
									gotoxy(34,10);
									writeln('1) Dar de alta');
									gotoxy(34,13);
									writeln('ESC) Volver');
									Control:=readkey;
									keypressed;
									if (Control = '1') then
									   begin
											Alta_Estado_Museo(Arch, Nom_Arch, Posi);
											gotoxy(25,22);
											textcolor(green);
											writeln('El museo ha sido dado de alta');
											textcolor(white);
											readkey;
									   end
									   else
										   if (Control=#27) then
											  clrscr
												 else
													 begin
														  textcolor(red);
														  gotoxy(20,22);
														  writeln(#7'Tecla no válida. Vuelva a intentar.');
														  textcolor(white);
														  readkey;
													 end;
							  until (Control = '1') or (Control = #27);
						  end;
			 end;
	end;

procedure Baja_Museo(var Arch:T_Museos; Nom_Arch:string; var Pos:integer);
	var
		Reg:R_Museos;
	begin
	   Leer_Museo(Arch, Nom_Arch, Pos, Reg);
	   Reg.Estado_Museo:=false;
	   Abrir_Museo(Arch, Nom_Arch);
	   seek(Arch, Pos);
	   write(Arch, Reg);
	   close(Arch);
	end;

procedure Alta_Estado_Museo(var Arch:T_Museos; Nom_Arch:string; var Pos:integer);
	var
		Reg:R_Museos;
	begin
	   Leer_Museo(Arch, Nom_Arch, Pos, Reg);
	   Reg.Estado_Museo:=true;
	   Abrir_Museo(Arch, Nom_Arch);
	   seek(Arch, Pos);
	   write(Arch, Reg);
	   close(Arch);
	end;

procedure Eliminar_Museo(var Arch:T_Museos);
	begin
	   erase(Arch);
	end;

procedure Busqueda_Nombre_Museo(var Arch:T_Museos; Nom_Arch:string; Busc:st30; var Pos:integer);
	var
		Reg_Aux:R_Museos;
		i:integer;
	begin
	   i:=0;
	   Pos := -1;
	   Abrir_Museo(Arch, Nom_Arch);
	   while not eof(Arch) do
	   begin
			read(Arch, Reg_Aux);
			if Reg_Aux.Nom_Museo = Busc then
			   begin
					Pos:=i;
			   end;
			i:=i+1;
			seek(Arch, i);
	   end;
	   close(Arch);
	end;

procedure Busqueda_Codigo_Museo(var Arch:T_Museos; Nom_Arch:string; Busc:integer; var Pos:integer);
	var
		Reg_Aux:R_Museos;
		i:integer;
	begin
	   i:=0;
	   Pos := -1;
	   Abrir_Museo(Arch, Nom_Arch);
	   while not eof(Arch) do
	   begin
			read(Arch, Reg_Aux);
			if Reg_Aux.Cod_Museo = Busc then
			   begin
					Pos:=i;
			   end;
			i:=i+1;
			seek(Arch, i);
	   end;
	   close(Arch);
	end;

procedure Busqueda_DNI_Director_Museo(var Arch:T_Museos; Nom_Arch:string; Busc:integer; var Pos:integer);
	var
		Reg_Aux:R_Museos;
		i:integer;
	begin
	   i:=0;
	   Pos := -1;
	   Abrir_Museo(Arch, Nom_Arch);
	   while not eof(Arch) do
	   begin
			read(Arch, Reg_Aux);
			if Reg_Aux.DNI_Direc = Busc then
			   begin
					Pos:=i;
			   end;
			i:=i+1;
			seek(Arch, i);
	   end;
	   close(Arch);
	end;

begin	
end.
