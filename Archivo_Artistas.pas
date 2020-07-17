unit Archivo_Artistas;

interface

uses crt;

type

	st30=string[30];
	
	R_Artistas=record
		DNI_Artista:integer;
		ApNom_Artista:st30;
		Direc_Artista:st30;
		Ciudad_Artista:st30;
		Pais_Artista:st30;
		Estado_Artista:Boolean;
		end;
	
	T_Artistas = file of R_Artistas;
	
	procedure Abrir_Artista(var Arch:T_Artistas; Nom_Arch:string);
	procedure Leer_Artista(var Arch:T_Artistas; Nom_Arch:string; var Pos:integer; var Leer_Dato:R_Artistas);
	procedure Guardar_Artista(var Arch:T_Artistas; Nom_Arch:string; var Escribir_Dato:R_Artistas);
	procedure Modificar_Artista(var Arch:T_Artistas; Nom_Arch:string ;Pos:integer);
	procedure Alta_Artista(var Arch:T_Artistas; Nom_Arch:string; var Reg:R_Artistas);
	procedure Baja_Artista(var Arch:T_Artistas; Nom_Arch:string; var Pos:integer);
	procedure Alta_Estado_Artista(var Arch:T_Artistas; Nom_Arch:string; var Pos:integer);
	procedure Eliminar_Artista(var Arch:T_Artistas);
	procedure Busqueda_ApNom_Artista(var Arch:T_Artistas; Nom_Arch:string; Busc:st30; var Pos:integer);
	procedure Busqueda_DNI_Artista(var Arch:T_Artistas; Nom_Arch:string; Busc:integer; var Pos:integer);


implementation

procedure Abrir_Artista(var Arch:T_Artistas; Nom_Arch:string);
	begin
		assign(Arch, Nom_Arch); // asigna arch interno y externo (Arch_Artistas en pascal, Archivo_Artistas.dat en ubuntu)
		{$I-} // deshabilita errores en el programa
			reset(Arch); // necesita la existencia del archivo, abre y lo lee
		{$I-}
		if ioresult <> 0 then //si ioresult <> 0 hubo un error en reset, por cual entra en rewrite
			rewrite(Arch); // crea y abre arch, si existe lo elimina
	end;

procedure Leer_Artista(var Arch:T_Artistas; Nom_Arch:string; var Pos:integer; var Leer_Dato:R_Artistas);
	begin
		Abrir_Artista(Arch, Nom_Arch);
		seek(Arch, Pos); // posiciona el puntero en la posicion a indicar
		read(Arch, Leer_Dato); //lee datos del archivo
		close(Arch);
	end;

procedure Guardar_Artista(var Arch:T_Artistas; Nom_Arch:string; var Escribir_Dato:R_Artistas);
	begin
		Abrir_Artista(Arch, Nom_Arch);
		seek(Arch, filesize(Arch)); // posiciona el puntero basandose en el tamaño del archivo
		write(Arch, Escribir_Dato);
		close(Arch);
	end;

procedure Modificar_Artista(var Arch:T_Artistas; Nom_Arch:string ;Pos:integer);
	var
		x,y,i:integer;
		Reg:R_Artistas;    
		Control:char;
	begin
	clrscr;
	Leer_Artista(Arch, Nom_Arch, Pos, Reg);
	if Reg.Estado_Artista then
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
		writeln('Nombre y Apellido: ', Reg.ApNom_Artista);
		gotoxy(5,9);
		writeln('Direccion: ', reg.Direc_Artista);
		gotoxy(5,10);
		writeln('Ciudad: ', reg.Ciudad_Artista);
		gotoxy(5,11);
		writeln('Pais: ', Reg.Pais_Artista);
		gotoxy(5,19);
		writeln(' Ingrese: ');
		gotoxy(56,6);
		textbackground(white);
		textcolor(128);	
		writeln('Que desea modificar?');
		textbackground(black);
		textcolor(white);
		gotoxy(56,8);
		writeln('1) Nombre y Apellido: ');
		gotoxy(56,9);
		writeln('2) Direccion: ');
		gotoxy(56,10);
		writeln('3) Ciudad: ');
		gotoxy(56,11);
		writeln('4) Pais: ');
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
					   readln(Reg.ApNom_Artista);
					   gotoxy(15,19);
					   writeln('                                                   ');
					   gotoxy(24,8);
					   writeln('                               ');
					   gotoxy(24,8);
					   writeln(Reg.ApNom_Artista);
					   Reg.Estado_Artista:=true;
					   Abrir_Artista(Arch, Nom_Arch);
					   seek(Arch, Pos);
					   write(Arch, Reg);
					   close(Arch);
				  end;
			  '2':begin
					   gotoxy(15,19);
					   readln(Reg.Direc_Artista);
					   gotoxy(15,19);
					   writeln('                                                   ');
					   gotoxy(16,9);
					   writeln('                                     ');
					   gotoxy(16,9); 
					   writeln(Reg.Direc_Artista);
					   Reg.Estado_Artista:=true;
					   Abrir_Artista(Arch, Nom_Arch);
					   seek(Arch, Pos);
					   write(Arch, Reg);
					   close(Arch);
				  end;
			  '3':begin
					   gotoxy(15,19);
					   readln(Reg.Ciudad_Artista);
					   gotoxy(15,19);
					   writeln('                                                   ');
					   gotoxy(13,10);
					   writeln('                                        ');
					   gotoxy(13,10);
					   writeln(Reg.Ciudad_Artista);
					   Reg.Estado_Artista:=true;
					   Abrir_Artista(Arch, Nom_Arch);
					   seek(Arch, Pos);
					   write(Arch, Reg);
					   close(Arch);
				  end;
			  '4':begin
					   gotoxy(15,19);
					   readln(Reg.Pais_Artista);
					   gotoxy(15,19);
					   writeln('                                                   ');
					   gotoxy(11,11);
					   writeln('                                          ');
					   gotoxy(11,11);
					   writeln(Reg.Pais_Artista);
					   Reg.Estado_Artista:=true;
					   Abrir_Artista(Arch, Nom_Arch);
					   seek(Arch, Pos);
					   write(Arch, Reg);
					   close(Arch);
				  end;
			end;
		until Control=#27;
		end
		else
			begin
			   gotoxy(20,22);
			   writeln(#7'El artista esta dado de baja. Dar de alta para continuar.');
			   readkey;
			end;
	end;

procedure Alta_Artista(var Arch:T_Artistas; Nom_Arch:string; var Reg:R_Artistas);
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
	Posi:=-1;
	gotoxy(15,5);
	writeln('ALTA DE ARTISTA');
	gotoxy(20,8);
	writeln('Nombre y Apellido: ');
	gotoxy(20,10);
	writeln('DNI: ');
	gotoxy(20,12);
	writeln('Direccion: ');
	gotoxy(20,14);
	writeln('Ciudad: ');
	gotoxy(20,16);
	writeln('Pais: ');
	gotoxy(39,8);
	readln(Clave);
	Busqueda_ApNom_Artista(Arch, Nom_Arch, Clave, Posi);
	if Posi = -1 then
	begin
	   Reg.ApNom_Artista:=Clave;
	   repeat
			 gotoxy(25,10);
			 writeln('                               ');
			 gotoxy(25,10);
			 {$I-}
			 	  readln(Reg.DNI_Artista);
			 {$I+}
			 Val:=ioresult();
			 if Val=0 then
				begin
					 Busqueda_DNI_Artista(Arch, Nom_Arch, Reg.DNI_Artista, Posi);
					 if Posi>-1  then
						begin
							 gotoxy(20,20);
							 writeln('                                                               ');
							 gotoxy(20,20);
							 textcolor(red);
							 writeln(#7'El DNI del artista ya existe. Vuelva a intentar.');
							 textcolor(white);
						end;
				end
				 else
				   begin
						gotoxy(20,20);
						writeln('                                                            ');
						gotoxy(20,20);
						textcolor(red);
						writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
						textcolor(white);
				   end;
	   until (Posi=-1) and (Val=0);
	   gotoxy(10,20);
	   writeln('                                                                   ');
	   gotoxy(31,12);
	   readln(Reg.Direc_Artista);
	   gotoxy(28,14);
	   readln(Reg.Ciudad_Artista);
	   gotoxy(26,16);
	   readln(Reg.Pais_Artista);
	   Reg.Estado_Artista:=true;
	   Guardar_Artista(Arch, Nom_Arch, Reg);
	   gotoxy(25,20);
	   textcolor(green);
	   writeln('El Artista ha sido dado de alta');
	   textcolor(white);
	   readkey;
	end
	 else
		 begin
			  Leer_Artista(Arch, Nom_Arch, Posi, Reg);
			  if (Reg.Estado_Artista) then
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
							writeln('Este artista ya esta registrado. Que desea hacer?');
							gotoxy(34,10);
							writeln('1) Modificar');
							gotoxy(34,12);
							writeln('2) Dar de baja');
							gotoxy(34,14);
							writeln('ESC) Volver');
							Control:=readkey;
							keypressed;
							if (Control = '1') then
							   Modificar_Artista(Arch, Nom_Arch, Posi)
								  else
								  if (Control='2') then
									 begin									 
										  Baja_Artista(Arch, Nom_Arch, Posi);
										  gotoxy(25,20);
										  textcolor(green);
										  writeln('El artista ha sido dado de baja');
										  textcolor(white);
										  readkey;
									 end
									 else
										if (Control=#27) then	// #27 escape								  
											clrscr								 
											else
												 begin
													  textcolor(red);
													  gotoxy(20,20);
													  writeln(#7'Tecla no válida. Vuelva a intentar.');
													  textcolor(white);
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
							   writeln(#7'Este artista esta registrado pero esta dado de baja.');
							   textcolor(white);
							   gotoxy(34,10);
							   writeln('1) Dar de alta');					   
							   gotoxy(34,13);
							   writeln('ESC) Volver');
							   Control:=readkey;
							   keypressed;
							   if (Control = '1') then
								  begin
									   Alta_Estado_Artista(Arch, Nom_Arch, Posi);
									   gotoxy(25,20);
									   textcolor(green);
									   writeln('El artista ha sido dado de alta');
									   readkey;
								  end
								  else
								  if (Control=#27) then
									clrscr
									else
									   begin
											clrscr;
											textcolor(red);
											gotoxy(20,20);
											writeln(#7'Tecla no válida. Vuelva a intentar.');
											textcolor(white);
											readkey;
									   end;
					 until (Control = '1') or (Control = #27);
				 end;
		 end;
	end;

procedure Baja_Artista(var Arch:T_Artistas; Nom_Arch:string; var Pos:integer);
	var
		Reg:R_Artistas;
	begin
	   Leer_Artista(Arch, Nom_Arch, Pos, Reg);
	   Reg.Estado_Artista:=false;
	   Abrir_Artista(Arch, Nom_Arch);
	   seek(Arch, Pos);
	   write(Arch, Reg);
	   close(Arch);
	end;

procedure Alta_Estado_Artista(var Arch:T_Artistas; Nom_Arch:string; var Pos:integer);
	var
		Reg:R_Artistas;
	begin
	   Leer_Artista(Arch, Nom_Arch, Pos, Reg);
	   Reg.Estado_Artista:=true;
	   Abrir_Artista(Arch, Nom_Arch);
	   seek(Arch, Pos);
	   write(Arch, Reg);
	   close(Arch);
	end;

procedure Eliminar_Artista(var Arch:T_Artistas);
	begin
	   erase(Arch);
	end;

procedure Busqueda_ApNom_Artista(var Arch:T_Artistas; Nom_Arch:string; Busc:st30; var Pos:integer);
	var
		Reg_Aux:R_Artistas;
		i:integer;
	begin
	   i:=0;
	   Pos:=-1;
	   Abrir_Artista(Arch, Nom_Arch);
	   while not eof(Arch) do // mientras no este al fin del archivo o el mismo este vacio
	   begin
			read(Arch, Reg_Aux);
			if Reg_Aux.ApNom_Artista = Busc then
			   begin
					Pos:=i;
			   end;
			i:=i+1;
			seek(Arch, i);
	   end;
	   close(Arch);
	end;

procedure Busqueda_DNI_Artista(var Arch:T_Artistas; Nom_Arch:string; Busc:integer; var Pos:integer);
	var
		Reg_Aux:R_Artistas;
		i:integer;
	begin
	   i:=0;
	   Pos:=-1;
	   Abrir_Artista(Arch, Nom_Arch);
	   while not eof(Arch) do
	   begin
			read(Arch, Reg_Aux);
			if Reg_Aux.DNI_Artista = Busc then
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
