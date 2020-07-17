unit Archivo_Directores;

interface

uses crt;

type

	st30=string[30];

	R_Directores=record
		DNI_Dir:integer;
		ApNom_Dir:st30;
		Direc_Dir:st30;
		Tel_Dir:longint;
		Per_Des:integer;
		Estado_Dir:Boolean;
		end;
	
	T_Directores = file of R_Directores;

	procedure Abrir_Director(var Arch:T_Directores; Nom_Arch:string);
	procedure Leer_Director(var Arch:T_Directores; Nom_Arch:string; var Pos:integer; var Leer_Dato:R_Directores);
	procedure Guardar_Director(var Arch:T_Directores; Nom_Arch:string; var Escribir_Dato:R_Directores);
	procedure Modificar_Director(var Arch:T_Directores; Nom_Arch:string; Pos:integer);
	procedure Alta_Director(var Arch:T_Directores; Nom_Arch:string; var Reg:R_Directores);
	procedure Baja_Director(var Arch:T_Directores; Nom_Arch:string; var Pos:integer);
	procedure Alta_Estado_Director(var Arch:T_Directores; Nom_Arch:string; var Pos:integer);
	procedure Eliminar_Director(var Arch:T_Directores);
	procedure Busqueda_ApNom_Director(var Arch:T_Directores; Nom_Arch:string; Busc:st30; var Pos:integer);
	procedure Busqueda_DNI_Director(var Arch:T_Directores; Nom_Arch:string; Busc:integer; var Pos:integer);
	

implementation

procedure Abrir_Director(var Arch:T_Directores; Nom_Arch:string);
	begin
		assign(Arch, Nom_Arch);
		{$I-}                       
			reset(Arch);
		{$I-}
		if ioresult <> 0 then
			rewrite(Arch);
	end;

procedure Leer_Director(var Arch:T_Directores; Nom_Arch:string; var Pos:integer; var Leer_Dato:R_Directores);
	begin
		Abrir_Director(Arch, Nom_Arch);
		seek(Arch, Pos);        
		read(Arch, Leer_Dato);
		close(Arch);
	end;

procedure Guardar_Director(var Arch:T_Directores; Nom_Arch:string; var Escribir_Dato:R_Directores);
	begin
		Abrir_Director(Arch, Nom_Arch);
		seek(Arch, filesize(Arch));
		write(Arch, Escribir_Dato);
		close(Arch);
	end;

procedure Modificar_Director(var Arch:T_Directores; Nom_Arch:string; Pos:integer);
	var
		Val,x,y,i:integer;
		Reg:R_Directores;
		Control:char;
	begin
	clrscr;
	Leer_Director(Arch, Nom_Arch, Pos, Reg);
	if Reg.Estado_Dir then
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
	   textcolor(white);
	   gotoxy(5,8);
	   writeln('Nombre y Apellido: ', Reg.ApNom_Dir);
	   gotoxy(5,9);
	   writeln('Direccion: ', Reg.Direc_Dir);
	   gotoxy(5,10);
	   writeln('Telefono: ', Reg.Tel_Dir);
	   gotoxy(5,11);
	   writeln('Periodo de designación: ',reg.Per_Des);
	   gotoxy(5,19);
	   writeln(' Ingrese: ');
	   gotoxy(56,6);
	   textbackground(white);
	   textcolor(128);	
	   writeln('Que desea modificar?');
	   textbackground(black);
	   textcolor(white);
	   gotoxy(56,8);
	   writeln('1) Nombre y apellido: ');
	   gotoxy(56,9);
	   writeln('2) Direccion: ');
	   gotoxy(56,10);
	   writeln('3) Telefono: ');
	   gotoxy(56,11);
	   writeln('4) Periodo de design.: ');
	   gotoxy(56,12);
	   writeln('ESC) Salir ');
	   repeat
			 gotoxy(10,20);
			 writeln('                                                          ');
			 Control:=readkey;
			 keypressed;
			 case Control of
				  '1':begin
						   gotoxy(15,19);
						   readln(Reg.ApNom_Dir);
						   gotoxy(15,19);
						   writeln('                                                   ');
						   gotoxy(24,8);
						   writeln('                              ');
						   gotoxy(24,8);
						   writeln(Reg.ApNom_Dir);
						   Reg.Estado_Dir:=true;
						   Abrir_Director(Arch, Nom_Arch);
						   seek(Arch, Pos);
						   write(Arch, Reg);
						   close(Arch);
					  end;
				   '2':begin
						   gotoxy(15,19);
						   readln(Reg.Direc_Dir);
						   gotoxy(15,19);
					       writeln('                                                   ');
						   gotoxy(16,9);
						   writeln('              ');
						   gotoxy(16,9);
						   writeln(Reg.Direc_Dir);
						   Reg.Estado_Dir:=true;
						   Abrir_Director(Arch, Nom_Arch);
						   seek(Arch, Pos);
						   write(Arch, Reg);
						   close(Arch);
					   end;
					'3':begin
							 repeat
								   gotoxy(10,20);
								   writeln('                                                                     ');
								   gotoxy(15,19);
								   writeln('                                                            ');
								   gotoxy(15,19);
								   {$I-}
										readln(Reg.Tel_Dir);
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
							 gotoxy(15,19);
							 writeln('                                             ');
							 gotoxy(15,10);
							 writeln('              ');
							 gotoxy(15,10);
							 writeln(Reg.Tel_Dir);
							 Reg.Estado_Dir:=true;
							 Abrir_Director(Arch, Nom_Arch);
							 seek(Arch, Pos);
							 write(Arch, Reg);
							 close(Arch);
						end;
					'4':begin
							 repeat
								   gotoxy(10,20);
								   writeln('                                                       ');
								   gotoxy(15,19);
								   writeln('                                                       ');
								   gotoxy(15,19);
								   {$I-}
										readln(Reg.Per_Des);
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
										   writeln(#7'Debe ingresar solo numeros. Vuelva a intentar');
										   textcolor(white);
										   readkey;
									  end;
							 until Val=0;
							 gotoxy(15,19);
							 writeln('                                                       ');
							 gotoxy(29,11);
							 writeln('                       ');
							 gotoxy(29,11);
							 writeln(Reg.Per_Des);
							 Reg.Estado_Dir:=true;
							 Abrir_Director(Arch, Nom_Arch);
							 seek(Arch, Pos);
							 write(Arch, Reg);
							 close(Arch);
						end;
			 end;
	   until Control=#27;
	   end
		  else
			  begin
				   textcolor(red);
				   writeln('El director esta dado de baja. Dar de alta para continuar.');
				   textcolor(white);
				   readkey;
			  end;
	end;

procedure Alta_Director(var Arch:T_Directores; Nom_Arch:string; var Reg:R_Directores);
	var
	Val,Posi,x,y,i:integer;
	Control:char;
	Clave:string;
	begin
	clrscr;
	textcolor(6);
	x:=12;
	y:=3;
	for i:=1 to 16 do // izq
		begin
			gotoxy(x,y);
			writeln('*');
			inc(y);
		end;
	x:=12;
	y:=3;
	for i:=1 to 30 do // arriba
		begin
			gotoxy(x,y);
			writeln('*');
			x:=x+2
		end;
	x:=70;
	y:=3;
	for i:=1 to 16 do // der
		begin
			gotoxy(x,y);
			writeln('*');
			inc(y);
		end;
	x:=12;
	y:=18;
	for i:=1 to 30 do // abajo
		begin
			gotoxy(x,y);
			writeln('*');
			x:=x+2
		end;
	textcolor(white);
	posi:=-1;
	gotoxy(15,5);
	writeln('ALTA DE DIRECTOR');
	gotoxy(20,8);
	writeln('Nombre y apellido: ');
	gotoxy(20,10);
	writeln('DNI: ');
	gotoxy(20,12);
	writeln('Direccion: ');
	gotoxy(20,14);
	writeln('Telefono: ');
	gotoxy(20,16);
	writeln('Periodo de designacion: ');
	gotoxy(39,8);
	readln(Clave);
	Busqueda_ApNom_Director(Arch, Nom_Arch, Clave, Posi);
	if Posi = -1 then
	  begin
		   Reg.ApNom_Dir:=Clave;
		   repeat
				 gotoxy(25,10);
				 writeln('                               ');
				 gotoxy(25,10);
				 {$I-}
					  readln(Reg.DNI_Dir);
				 {$I+}
				 Val:=ioresult();
				 if Val=0 then
					begin
						 Busqueda_DNI_Director(Arch, Nom_Arch, Reg.DNI_Dir, Posi);
						 if Posi>-1 then
							begin
								 gotoxy(20,20);
								 textcolor(red);
								 writeln(#7'El DNI del director ya existe. Vuelva a intentar');
								 textcolor(white);
							end;
						 end
							else
								begin
									 gotoxy(20,20);
									 textcolor(red);
									 writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
									 textcolor(white);
								end;
		   until (Posi=-1) and (Val=0);
		   gotoxy(15,20);
		   writeln('                                                                   ');
		   gotoxy(31,12);
		   readln(Reg.Direc_Dir);
		   repeat
						gotoxy(30,14);
						writeln('                                        ');
						gotoxy(30,14);
						{$I-}
							 readln(Reg.Tel_Dir);
						{$I+}
						Val:=ioresult();
						if Val<>0 then
						   begin
								gotoxy(20,20);
								textcolor(red);
								writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
								textcolor(white);
						   end;
				   until Val=0;
				   gotoxy(15,20);
				   writeln('                                                                 ');
				   repeat
						  gotoxy(44,16);
						  writeln('                       ');
						  gotoxy(44,16);
						 {$I-}
							  readln(Reg.Per_Des);
						 {$I+}
						 Val:=ioresult();
						 if Val<>0 then
							begin
								gotoxy(20,20);
								textcolor(red);
								writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
								textcolor(white);
							end;
				   until Val=0;
		   Reg.Estado_Dir:=true;
		   Guardar_Director(Arch, Nom_Arch, Reg);
		   gotoxy(20,20);
		   writeln('                                                      ');
		   gotoxy(25,20);
		   textcolor(green);
		   writeln('El director ha sido dado de alta');
		   textcolor(white);
		   readkey;
	  end
		 else
			 begin
				  Leer_Director(Arch, Nom_Arch, Posi, Reg);
				  if (Reg.Estado_Dir) then
					 begin
						  repeat
								clrscr;
								textcolor(6);
								x:=12;
								y:=3;
								for i:=1 to 16 do // izq
									begin
										gotoxy(x,y);
										writeln('*');
										inc(y);
									end;
								x:=12;
								y:=3;
								for i:=1 to 30 do // arriba
									begin
										gotoxy(x,y);
										writeln('*');
										x:=x+2
									end;
								x:=70;
								y:=3;
								for i:=1 to 16 do // der
									begin
										gotoxy(x,y);
										writeln('*');
										inc(y);
									end;
								x:=12;
								y:=18;
								for i:=1 to 30 do // abajo
									begin
										gotoxy(x,y);
										writeln('*');
										x:=x+2
									end;
								textcolor(white);
								gotoxy(17,6);
								writeln('Este director ya esta registrado. Que desea hacer?');
								gotoxy(34,10);
								writeln('1) Modificar');
								gotoxy(34,12);
								writeln('2) Dar de baja');
								gotoxy(34,14);
								writeln('ESC) Volver');
								Control:=readkey;
								keypressed;
								if (Control = '1') then
								   Modificar_Director(Arch, Nom_Arch, Posi)
									  else
										  if (Control='2') then
											 begin
												  Baja_Director (Arch, Nom_Arch, Posi);
												  gotoxy(25,20);
												  textcolor(green);
												  writeln('El director ha sido dado de baja');
												  textcolor (white);
												  readkey;
											 end
											  else
												  if (Control=#27) then
													 clrscr
														else
															 begin
																  gotoxy(20,20);
																  textcolor(red);
																  writeln(#7'Tecla no válida. Vuelva a intentar.');
																  textcolor(white);
																  readkey;
															 end;
						  until (Control = '1') or (Control='2') or (Control='3') or (Control = #27);
					 end
					 else
					 begin
						 repeat
							    clrscr;
								textcolor(yellow);
								x:=12;
								y:=3;
								for i:=1 to 16 do // izq
									begin
										gotoxy(x,y);
										writeln('*');
										inc(y);
									end;
								x:=12;
								y:=3;
								for i:=1 to 30 do // arriba
									begin
										gotoxy(x,y);
										writeln('*');
										x:=x+2
									end;
								x:=70;
								y:=3;
								for i:=1 to 16 do // der
									begin
										gotoxy(x,y);
										writeln('*');
										inc(y);
									end;
								x:=12;
								y:=18;
								for i:=1 to 30 do // abajo
									begin
										gotoxy(x,y);
										writeln('*');
										x:=x+2
									end;
								   textcolor(red);
								   gotoxy(16,6);
								   writeln(#7'Este director esta registrado pero esta dado de baja');
								   textcolor(white);
								   gotoxy(34,10);
								   writeln('1) Dar de alta');
								   gotoxy(34,13);
								   writeln('ESC) Volver');
								   Control:=readkey;
								   keypressed;
								   if (control = '1') then
									  begin
										   Alta_Estado_Director(Arch, Nom_Arch, Posi);
										   gotoxy(25,20);
										   textcolor(green);
										   writeln('El director ha sido dado de alta');
										   readkey;
									  end
										 else
											 if (control=#27) then
												clrscr
												   else
													   begin
															gotoxy(20,20);
															textcolor(red);
															writeln(#7'Tecla no válida. Vuelva a intentar.');
															textcolor(white);
															readkey;
													   end;
							 until (Control = '1') or (Control = #27);
						  end;
			 end;
	end;

procedure Baja_Director(var Arch:T_Directores; Nom_Arch:string; var Pos:integer);
	var
		Reg:R_Directores;
	begin
	   Leer_Director(Arch, Nom_Arch, Pos, Reg);
	   Reg.Estado_Dir:=false;
	   Abrir_Director(Arch, Nom_Arch);
	   seek(Arch, Pos);
	   write(Arch, Reg);
	   close(Arch);
	end;

procedure Alta_Estado_Director(var Arch:T_Directores; Nom_Arch:string; var Pos:integer);
	var
		Reg:R_Directores;
	begin
	   Leer_Director(Arch, Nom_Arch, Pos, Reg);
	   Reg.Estado_Dir:=true;
	   Abrir_Director(Arch, Nom_Arch);
	   seek(Arch, Pos);
	   write(Arch, Reg);
	   close(Arch);
	end;

procedure Eliminar_Director(var Arch:T_Directores);
	begin
	   erase(Arch);
	end;

procedure Busqueda_ApNom_Director(var Arch:T_Directores; Nom_Arch:string; Busc:st30; var Pos:integer);
	var
		Reg_Aux:R_Directores;
		i:integer;
	begin
	   i:=0;
	   Pos := -1;
	   Abrir_Director(Arch, Nom_Arch);
	   while not eof(Arch) do
	   begin
			read(Arch, Reg_Aux);
			if Reg_Aux.ApNom_Dir = Busc then
			   begin
					Pos:=i;
			   end;
			i:=i+1;
			seek(Arch, i);
	   end;
	   close(Arch);
	end;

procedure Busqueda_DNI_Director(var Arch:T_Directores; Nom_Arch:string; Busc:integer; var Pos:integer);
	var
		Reg_Aux:R_Directores;
		i:integer;
	begin
	   i:=0;
	   Pos := -1;
	   Abrir_Director(Arch, Nom_Arch);
	   while not eof(Arch) do
	   begin
			read(Arch, Reg_Aux);
			if Reg_Aux.DNI_Dir = Busc then
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
