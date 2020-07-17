unit Archivo_Obras;

interface

uses crt, Archivo_Artistas, Archivo_Museos;

type

	st2=string[2];
	st30=string[30];
	st50=string[50];

	//archivo

	R_Obras=record
		Cod_Obra:integer;
		Cod_Museo:integer;
		Nom_Obra:st30;
		DNI_Artista:integer;
		Anio:integer;
		Descripcion:st50;
		Tipo:st30; //pint, estatua, fosiles
		Material:st30;
		Estilo:st30;
		Altura:real;
		Peso:real;
		Completo:st2;
		Cant_Partes:integer;
		Estado_Obra:Boolean;
		end;
	
	T_Obras = file of R_Obras;

	procedure Abrir_Obra(var Arch:T_Obras; Nom_Arch:string);
	procedure Leer_Obra(var Arch:T_obras; Nom_Arch:string; var Pos:integer; var Leer_Dato:R_Obras);
	procedure Guardar_Obra(var Arch:T_Obras; Nom_Arch:string; var Escribir_Dato:R_Obras);
	procedure Modificar_Obra(var Arch:T_Obras; var Arch_Art:T_Artistas ; var Arch_Mus:T_Museos ; Nom_Arch:string; Nom_Arch_Art:string; Nom_Arch_Mus:string ; Pos:integer);
	procedure Alta_Obra(var Arch:T_Obras; var Arch_Art:T_Artistas; var Arch_Mus:T_Museos; Nom_Arch_Mus:string ; Nom_Arch_Art:string; Nom_Arch:string; var Reg:R_Obras);
	procedure Baja_Obra(var Arch:T_Obras; Nom_Arch:string; var Pos:integer);
	procedure Alta_Estado_Obra(var Arch:T_Obras; Nom_Arch:string; var Pos:integer);
	procedure Eliminar_Obra(var Arch:T_Obras);
	procedure Busqueda_Nombre_Obra(var Arch:T_Obras; Nom_Arch:string; Busc:st30; var Pos:integer);
	procedure Busqueda_Codigo_Obra(var Arch:T_Obras; Nom_Arch:string; Busc:integer; var Pos:integer);
	procedure Busqueda_Consulta_Artista(var Arch:T_Obras; Nom_Arch:string; Busc:integer; var Pos:integer);
	procedure Busqueda_Consulta_Museo(var Arch:T_Obras; Nom_Arch:string; Busc:integer; var Pos:integer);
	procedure Estadistica_Museo(var Arch:T_Obras; Nom_Arch:string; Busc:integer; var Pos:integer);


implementation


procedure Abrir_Obra(var Arch:T_Obras; Nom_Arch:string);
	begin
		assign(Arch, Nom_Arch);
		{$I-}   
			reset(Arch);
		{$I-}
		if ioresult <> 0 then
			rewrite(Arch);
	end;

procedure Leer_Obra(var Arch:T_Obras; Nom_Arch:string; var Pos:integer; var Leer_Dato:R_Obras);
	begin
		Abrir_Obra(Arch, Nom_Arch);
		seek(Arch, Pos); 
		read(Arch, Leer_Dato); 
		close(Arch);
	end;

procedure Guardar_Obra(var Arch:T_Obras; Nom_Arch:string; var Escribir_Dato:R_Obras);
	var
		Reg:R_Obras;
		Pos:integer;
	begin
		Pos:=0;
		Leer_Obra(Arch, Nom_Arch, Pos, Reg);
		Abrir_Obra(Arch, Nom_Arch);
		seek(Arch, filesize(Arch));
		if filepos(Arch) = 1 then
			begin
				if Reg.Cod_Obra = 0 then
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

procedure Modificar_Obra(var Arch:T_Obras; var Arch_Art:T_Artistas ; var Arch_Mus:T_Museos ; Nom_Arch:string; Nom_Arch_Art:string; Nom_Arch_Mus:string ; Pos:integer);
	var
		Reg:R_Obras;
		Control:char;
		Val,Posi,x,y,i:integer;
		Reg_Art:R_Artistas;
	begin
		clrscr;
		Leer_Obra(Arch, Nom_Arch, Pos, Reg);
		if Reg.Estado_Obra then
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
		gotoxy(5,7);
		writeln('Nombre de la obra: ', Reg.Nom_Obra);
		gotoxy(5,8);
		writeln('DNI del artista: ', Reg.DNI_Artista);
		gotoxy(5,9);
		writeln('Estilo: ', Reg.Estilo);
		gotoxy(5,10);
		writeln('Material: ', Reg.Material);
		gotoxy(5,11);
		writeln('Descripcion: ', Reg.Descripcion);
		gotoxy(5,12);
		writeln('Tipo: ', Reg.Tipo);
		if (Reg.Tipo = 'Estatua') then
		  begin
			   gotoxy(5,14);
			   writeln('Altura: ', Reg.Altura:2:2);
			   gotoxy(5,15);
			   writeln('Peso: ', Reg.Peso:2:2);
		  end
			 else
				 begin
					  if (Reg.Tipo = 'Fosil') then
						 begin
							  gotoxy(5,14);
							  writeln('Completo: ',Reg.Completo);
							  gotoxy(5,15);
							  writeln('Cantidad de partes: ', Reg.Cant_Partes);
						 end;
				 end;
	   gotoxy(5,13);
	   writeln('Año: ', Reg.Anio);
	   gotoxy(5,19);
	   writeln(' Ingrese: ');	   
	   gotoxy(58,5);
	   textbackground(white);
	   textcolor(128);
	   writeln('QUE DESEA MODIFICAR?');
	   textbackground(black);
	   textcolor(white);
	   gotoxy(56,7);
	   writeln('1) Nombre de la obra: ');
	   gotoxy(56,8);
	   writeln('2) DNI del artista: ');
	   gotoxy(56,9);
	   writeln('3) Estilo: ');
	   gotoxy(56,10);
	   writeln('4) Material: ');
	   gotoxy(56,11);
	   writeln('5) Descripcion: ');
	   gotoxy(56,12);
	   writeln('6) Tipo: ');
	   if (Reg.Tipo = 'Estatua') then
		  begin
			   gotoxy(56,14);
			   writeln('A) Altura: ');
			   gotoxy(56,15);
			   writeln('B) Peso: ');
		  end
			 else
				 begin
					  if (Reg.Tipo = 'Fosil') then
						 begin
							  gotoxy(56,14);
							  writeln('C) Completo: ');
							  gotoxy(56,15);
							  writeln('D) Cantidad de partes: ');
						 end
							else
								begin
									 gotoxy(56,14);
									 writeln('                      ');
									 gotoxy(56,15);
									 writeln('                       ');
								end
				 end;

	   gotoxy(56,13);
	   writeln('7) Año: ');
	   gotoxy(56,16);
	   writeln('ESC) Salir');
	   repeat
			 gotoxy(10,20);
			 writeln('                                                                    ');
			 Control:=readkey;
			 keypressed;
			 case Control of
			 '1':begin
					  gotoxy(15,19);
					  readln(Reg.Nom_Obra);
					  gotoxy(15,19);
					  writeln('                                                               ');
					  gotoxy(24,7);
					  writeln('                                 ');					  
					  gotoxy(24,7);
					  writeln(Reg.Nom_Obra);							  
					  Abrir_Obra(Arch, Nom_Arch);
					  seek(Arch, Pos);
					  write(Arch, Reg);
					  close(Arch);
				 end;
			 '2':begin
					  gotoxy(15,19);
					  writeln('                                                        ');
					  gotoxy(15,19);
					  {$I-}
						   readln(Reg.DNI_Artista);
					  {$I+}
					  Val:=ioresult();
					  if Val=0 then
						begin
							  Busqueda_DNI_Artista(Arch_Art, Nom_Arch_Art, Reg.DNI_Artista, Posi);
							  if Posi > -1 then
								 begin
									  Leer_Artista(Arch_Art, Nom_Arch_Art, Posi, Reg_Art);
									  if Reg_Art.Estado_Artista then
										 begin
											  gotoxy(15,19);
											  writeln('                                                  ');
											  gotoxy(22,8);
											  writeln('                              ');	
											  gotoxy(22,8);
											  writeln(Reg.DNI_Artista);
											  Abrir_Obra(Arch, Nom_Arch);
											  seek(Arch, Pos);
											  write(Arch, Reg);
											  close(Arch);
										 end
										 else
											 begin
											     gotoxy(15,19);
												 writeln('                                                            ');
												 gotoxy(10,20);
												 writeln('                                                               ');
												 gotoxy(10,20);
												 textcolor(red);
												 writeln(#7'El artista ha sido dado de baja. Dar de alta para continuar.');
												 textcolor(white);
												 readkey;
											 end;
								 end
								 else
									 begin
										 gotoxy(15,19);
										 writeln('                                                                ');
										 gotoxy(10,20);
										 writeln('                                                                     ');
										 textcolor(red);
										 gotoxy(10,20);
										 writeln(#7'El artista no esta registrado. Dar de alta para continuar.');
										 textcolor(white);
										 readkey;
									 end;
						 end
						 else
							begin
								 gotoxy(15,19);
								 writeln('                                                                  ');
								 gotoxy(10,20);
								 writeln('                                                                        ');
								 textcolor(red);
								 gotoxy(10,20);
								 writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
								 textcolor(white);
								 readkey;
							end;
				 end;
			 '3':begin				  
					  gotoxy(15,19);
					  readln(Reg.Estilo);
					  gotoxy(15,19);
					  writeln('                                                                   ');
					  gotoxy(13,9);
					  writeln('                                  ');	
					  gotoxy(13,9);
					  writeln(Reg.Estilo);
					  Abrir_Obra(Arch, Nom_Arch);
					  seek(Arch, Pos);
					  write(Arch, Reg);
					  close(Arch);
				 end;
			 '4':begin
					  gotoxy(15,19);
					  readln(Reg.Material);
					  gotoxy(15,19);
					  writeln('                                                               ');
					  gotoxy(15,10);
					  writeln('                                   ');
					  gotoxy(15,10);
					  writeln(Reg.Material);
					  Abrir_Obra(Arch, Nom_Arch);
					  seek(Arch, Pos);
					  write(Arch, Reg);
					  close(Arch);
				 end;
			 '5':begin
					  gotoxy(15,19);
					  readln(Reg.Descripcion);
					  gotoxy(15,19);
					  writeln('                                                                 ');
					  gotoxy(18,11);
					  writeln('                                    ');
					  gotoxy(18,11);
					  writeln(Reg.Descripcion);
					  Abrir_Obra(Arch, Nom_Arch);
					  seek(Arch, Pos);
					  write(Arch, Reg);
					  close(Arch);
				 end;
			 '6':begin
					  gotoxy(15,19);
					  writeln('                                                ');
					  textcolor(yellow);
					  gotoxy(15,19);
					  writeln('P:Pintura ; E:Estatua; F:Fosil');
					  textcolor(white);
					  Reg.Tipo:=readkey;
					  keypressed;				  
					  if (Reg.Tipo='p') or (Reg.Tipo='e') or (Reg.Tipo='f') then				 
						 begin
						 gotoxy(15,19);
						 writeln('                                      ');
							  if Reg.Tipo='p' then
								 begin
									  Reg.Tipo:='Pintura';
									  gotoxy(11,12);
									  writeln(Reg.Tipo);
									  gotoxy(5,14);
									  writeln('                       ');
									  gotoxy(5,15);
									  writeln('                       ');
									  gotoxy(56,14);
									  writeln('                       ');
									  gotoxy(56,15);
									  writeln('                       ');								  
									  Abrir_Obra(Arch, Nom_Arch);
									  seek(Arch, Pos);
									  write(Arch, Reg);
									  close(Arch);
								 end
								 else
									 if Reg.Tipo='f' then
										begin
											 Reg.Tipo:='Fosil';
											 gotoxy(11,12);
											 writeln(Reg.Tipo);
											 Reg.Completo:='No';
											 Reg.Cant_Partes:=0;
											 gotoxy(5,14);
											 writeln('                               ');
											 gotoxy(5,14);
											 writeln('Completo: ', Reg.Completo);
											 gotoxy(5,15);									 
											 writeln('                               ');
											 gotoxy(5,15);  
											 writeln('Cantidad de partes: ', Reg.Cant_Partes);									 
											 gotoxy(56,14);
											 writeln('C) Completo: ');
											 gotoxy(56,15);
											 writeln('D) Cantidad de partes: ');
											 Abrir_Obra(Arch, Nom_Arch);
											 seek(Arch, Pos);
											 write(Arch, Reg);
											 close(Arch);
										end
										else
											begin
												 Reg.Tipo:='Estatua';
												 gotoxy(11,12);
												 writeln(Reg.Tipo);
												 Reg.Altura:=0;
												 Reg.Peso:=0;
												 gotoxy(5,14);
												 writeln('                       ');
												 gotoxy(5,14);
												 writeln('Altura: ', Reg.Altura:2:2);
												 gotoxy(5,15);
												 writeln('                        ');
												 gotoxy(5,15);
												 writeln('Peso: ', Reg.Peso:2:2);
												 gotoxy(56,14); 
												 writeln('                       ');
												 gotoxy(56,14);
												 writeln('A) Altura: ');
												 gotoxy(56,15);
												 writeln('                       ');
												 gotoxy(56,15);
												 writeln('B) Peso: ');
												 Abrir_Obra(Arch, Nom_Arch);
												 seek(Arch, Pos);
												 write(Arch, Reg);
												 close(Arch);
											end;
					          gotoxy(11,12);
					          writeln('                      ');
							  gotoxy(11,12);
							  writeln(Reg.Tipo);
						   end
							  else
								  begin
									   gotoxy(15,19);
					                   writeln('                                                  ');
									   gotoxy(10,20);
									   writeln('                                                                    ');
									   gotoxy(10,20);
									   textcolor(red);
									   writeln(#7'Solo puede elegir entre P, E o F. Vuelva a intentar.');
									   textcolor(white);
									   readkey;
								  end;

				 end;
			 '7':begin
			 		  gotoxy(15,19);
					  {$I-}
						   readln(Reg.Anio);
					  {$I+}
					  Val:=ioresult();
					  if Val = 0 then
						 begin
							  gotoxy(15,19);
					          writeln('                                         ');
							  gotoxy(10,13);
							  writeln('                        ');
							  gotoxy(10,13);
							  writeln(Reg.Anio);
							  Abrir_Obra(Arch, Nom_Arch);
							  seek(Arch, Pos);
							  write(Arch, Reg);
							  close(Arch);
						 end
							else
								begin
									 gotoxy(15,19);
									 writeln('                                           ');
									 gotoxy(10,20);
									 writeln('                                                              ');
									 gotoxy(10,20);
									 textcolor(red);
									 writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
									 textcolor(white);
									 readkey;
								end;
				 end;
			 'a':begin
					  gotoxy(15,19);
					  {$I-}
						   readln(Reg.Altura);
					  {$I+}
					  Val:=ioresult();
					  if Val = 0 then
					  	 begin
							  gotoxy(15,19);
							  writeln('                                            ');
					     	  gotoxy(13,14);
							  writeln('                                          ');
							  gotoxy(13,14);
							  writeln(Reg.Altura:2:2);
							  Abrir_Obra(Arch, Nom_Arch);
							  seek(Arch, Pos);
							  write(Arch, Reg);
							  close(Arch);
						 end
					  else
						 begin
						      gotoxy(15,19);
							  writeln('                                                          ');
							  gotoxy(10,20);
							  writeln('                                                            ');
							  gotoxy(10,20);
							  textcolor(red);
							  writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
							  textcolor(white);
							  readkey;
						 end;
				 end;
			 'b':begin
				 	  gotoxy(15,19);
				 	  {$I-}
				 		   readln(Reg.Peso);
				 	  {$I+}
				 	  if ioresult = 0 then
				 		 begin
				 			  gotoxy(15,19);
				 	          writeln('                                            ');
				 			  gotoxy(11,15);
				 			  writeln('                                          ');
				 			  gotoxy(11,15);
				 			  writeln(Reg.Peso:2:2);
				 			  Abrir_Obra(Arch, Nom_Arch);
				 			  seek(Arch, Pos);
				 			  write(Arch, Reg);
				 			  close(Arch);
				 		 end
				 	  else
				 		 begin
							  gotoxy(15,19);
							  writeln('                                              ');
							  gotoxy(10,20);
							  writeln('                                                             ');
							  gotoxy(10,20);
							  textcolor(red);
							  writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
							  textcolor(white);
							  readkey;
				 		 end;
				  end;
			 'c':begin
					  textcolor(6);
					  gotoxy(15,19);
					  writeln('Presione S:Si ; N:No');
					  textcolor(white);
					  gotoxy(15,19);
					  writeln('                                    ');
					  gotoxy(15,19);
					  Reg.Completo:=readkey;
					  keypressed;
					  if Reg.Completo='s' then
						 begin
						      gotoxy(15,14);
							  writeln('           ');
							  Reg.Completo:='Si';
							  gotoxy(15,14);
							  writeln(Reg.Completo);
							  Abrir_Obra(Arch, Nom_Arch);
							  seek(Arch, Pos);
							  write(Arch, Reg);
							  close(Arch);
						 end
							else
								begin
									 if Reg.Completo='n' then
										begin
											 gotoxy(15,14);
											 writeln('               ');
											 Reg.Completo:='No';
											 gotoxy(15,14);
											 writeln(Reg.Completo);									
											 Abrir_Obra(Arch, Nom_Arch);
											 seek(Arch, Pos);
											 write(Arch, Reg);
											 close(Arch);
										end
										   else
											   begin
													gotoxy(15,19);
													writeln('                                              ');
													gotoxy(10,20);
													writeln('                                                                ');
													gotoxy(10,20);
													textcolor(red);
													writeln(#7'Solo puede elegir entre S o N. Vuelva a intentar.');
													textcolor(white);
													readkey;
											   end;
								end;
				 end;
			 'd':begin
					  gotoxy(15,19);
					  {$I-}
						   readln(Reg.Cant_Partes);
					  {$I+}
					  if ioresult = 0 then
						 begin
							  gotoxy(15,19);
					          writeln('                                            ');
							  gotoxy(25,15);
							  writeln('                             ');
							  gotoxy(25,15);
							  writeln(Reg.Cant_Partes);
							  Abrir_Obra(Arch, Nom_Arch);
							  seek(Arch, Pos);
							  write(Arch, Reg);
							  close(Arch);
						 end
							else
								begin
									 gotoxy(15,19);
					                 writeln('                                        ');
									 gotoxy(10,20);
									 writeln('                                                           ');
									 gotoxy(10,20);
									 textcolor(red);
									 writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
									 textcolor(white);
									 readkey;
								end;
				 end;
			 end;
	   until Control = #27;
	   end
		  else
			  begin
				   gotoxy(10,20);
				   writeln('                                                                ');
				   textcolor(green);
				   writeln('La obra esta dada de baja');
				   textcolor(white);
				   readkey;
			  end;
	end;

procedure Alta_Obra(var Arch:T_Obras; var Arch_Art:T_Artistas; var Arch_Mus:T_Museos; Nom_Arch_Mus:string ; Nom_Arch_Art:string; Nom_Arch:string; var Reg:R_Obras);
	var
		Val,Posi,x,y,i:integer;
		Control:char;
		Clave:string;
		Reg_Art:R_Artistas;
		Reg_Mus:R_Museos;
		Reg_Obr2:R_Obras;
		Ultima_Pos:integer;
	begin
		Abrir_Obra(Arch, Nom_Arch);
		if filesize(Arch)=0 then
		begin
		   Reg.Cod_Obra:=0;
		   write(Arch, Reg)
		end;         
		close(Arch);
		clrscr;
		textcolor(6);
		x:=12;
		y:=2;
		for i:=1 to 19 do //izq
			begin
				gotoxy(x,y);
				writeln('*');
				inc(y);
			end;
		x:=12;
		y:=2;
		for i:=1 to 29 do //arriba
			begin
				gotoxy(x,y);
				writeln('*');
				x:=x+2
			end;
		x:=70;
		y:=2;
		for i:=1 to 19 do //der
			begin
				gotoxy(x,y);
				writeln('*');
				inc(y);
			end;
		x:=12;
		y:=20;
		for i:=1 to 29 do //abajo
			begin
				gotoxy(x,y);
				writeln('*');
				x:=x+2
			end;
	   textcolor(white);
	   posi:=-1;
	   gotoxy(15,4);
	   writeln('ALTA DE OBRA');
	   gotoxy(20,7);
	   writeln('Nombre: ');
	   gotoxy(20,8);
	   writeln('DNI del Artista: ');
	   gotoxy(20,9);
	   writeln('Codigo del museo: ');
	   gotoxy(20,10);
	   writeln('Estilo: ');
	   gotoxy(20,11);
	   writeln('Material: ');
	   gotoxy(20,12);
	   writeln('Descripcion: ');
	   gotoxy(20,13);
	   writeln('Año: ');
	   gotoxy(20,14);
	   writeln('Tipo: ');
	   gotoxy(20,18);
	   writeln('Codigo: ');
	   gotoxy(28,7);
	   readln(Clave);
	   Abrir_Obra(Arch, Nom_Arch);
	   Ultima_Pos:=filesize(Arch)-1; // lectura de la posicion del ultimo registro
	   close(Arch);        
	   Leer_Obra(Arch, Nom_Arch, Ultima_Pos, Reg_Obr2);
	   Reg.Cod_Obra:=Reg_Obr2.Cod_Obra + 1;   // generar codigo de obra automaticamente
	   gotoxy(28,18);
	   writeln(Reg.Cod_Obra);
	   Busqueda_Nombre_Obra(Arch, Nom_Arch, Clave, Posi);
	   if Posi = -1 then
		  begin
			   Reg.Nom_Obra:=Clave;
			   repeat
					 gotoxy(37,8);
					 writeln('                             ');
					 gotoxy(37,8);
					 {$I-}
						  readln(Reg.DNI_Artista);
					 {$I+}
					 Val:=ioresult();
					 if Val<>0 then
						begin
							 gotoxy(20,22);
							 textcolor(red);
							 writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
							 textcolor(white);
						end;
			   until Val = 0;
			   gotoxy(20,22);
			   writeln('                                                                  ');
			   Busqueda_DNI_Artista(Arch_Art, Nom_Arch_Art, Reg.DNI_Artista, Posi);
			   if Posi > -1 then
				  begin
				  Leer_Artista(Arch_Art, Nom_Arch_Art, Posi, Reg_Art);
				  if Reg_Art.Estado_Artista then
					 begin
						  repeat
								gotoxy(38,9);
								writeln('                         ');
								gotoxy(38,9);
								{$I-}
									 readln(Reg.Cod_Museo);
								{$I-}
								Val:=ioresult();
								if Val <> 0 then
								   begin
										gotoxy(20,22);
										textcolor(red);
										writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
										textcolor(white);
								   end;
						  until Val = 0;
						  gotoxy(20,22);
						  writeln('                                                            ');
						  Busqueda_Codigo_Museo(Arch_Mus, Nom_Arch_Mus, Reg.Cod_Museo, Posi);
						  if Posi > -1 then
							 begin
								  Leer_Museo(Arch_Mus, Nom_Arch_Mus, Posi, Reg_Mus);
								  if Reg_Art.Estado_Artista then
								  begin
									   gotoxy(28,10);
									   readln(Reg.Estilo);
									   gotoxy(30,11);
									   readln(Reg.Material);
									   gotoxy(33,12);
									   readln(Reg.Descripcion);
									   repeat
											 gotoxy(25,13);
											 writeln('                          ');
											 gotoxy(25,13);
											 {$I-}
												  readln(Reg.Anio);
											 {$I+}
											 Val:=ioresult(); 
											 if Val<>0 then
												begin
													 gotoxy(20,22);
													 textcolor(red);
													 writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
													 textcolor(white);
												end;
									   until Val = 0;
									   gotoxy(15,22);
									   writeln('                                                           ');
									   repeat
											 textcolor(6);
											 gotoxy(15,22);
										     writeln('P:Pintura ; E:Estatua; F:Fosil');
											 textcolor(white);
											 gotoxy(26,14);
											 writeln('                         ');
											 gotoxy(26,14);
											 Control:=readkey;
											 keypressed;
											 case Control of
												  'e':begin
														   Reg.Tipo:='Estatua';
														   gotoxy(26,14);
														   writeln(Reg.Tipo);
													  end;
												  'f':begin
														   Reg.Tipo:='Fosil';
														   gotoxy(26,14);
														   writeln(Reg.Tipo);
													  end;
												  'p':begin
														   Reg.Tipo:='Pintura';
														   gotoxy(26,14);
														   writeln(Reg.Tipo);
													  end;
												  else
													  begin
														   gotoxy(20,22);
														   Textcolor(red);
														   writeln(#7'Solo puede elegir entre P, E o F. Vuelva a intentar.');
														   Textcolor (white);
													  end;
											 end;
									   until (Reg.Tipo = 'Estatua') or (Reg.Tipo = 'Fosil') or (Reg.Tipo = 'Pintura');
									   gotoxy(15,22);
									   writeln('                                                                  ');
									   if Reg.Tipo='Estatua' then
										  begin
											   gotoxy(20,15);
											   writeln('Altura: ');
											   gotoxy(20,16);
											   writeln('Peso: ');
											   repeat
													 gotoxy(28,15);
													 writeln('               ');
													 gotoxy(28,15);
													 {$I-}
														  readln(Reg.Altura);
													 {$I+}
													 Val:=ioresult(); 
													 if Val<>0 then
														begin
															 gotoxy(20,22);
															 textcolor(red);
															 writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
															 textcolor(white);
														end;
											   until Val = 0;
											   gotoxy(20,22);
											   writeln('                                                       ');
											   repeat 
													 gotoxy(26,16);
													 writeln('                   ');
													 gotoxy(26,16);
													 {$I-}
														  readln(Reg.Peso);
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
											   writeln('                                                             ');
										  end
											 else
												 if Reg.Tipo='Fosil' then
													begin
														 gotoxy(20,15);
														 writeln('Completo: ');
														 gotoxy(20,16);
														 writeln('Cantidad de partes: ');
														 repeat
															   textcolor(6);
															   gotoxy(20,22);
															   writeln('Presione "S": si esta completo, "N: si esta incompleto');
															   textcolor(white);
															   gotoxy(30,15);
															   writeln('            ');
															   gotoxy(30,15);
															   Control:=readkey;
															   keypressed;
															   case Control of
																	's':begin
																			 Reg.Completo:='Si';
																			 gotoxy(30,15);
																			 writeln(Reg.Completo);
																		end;
																	'n':begin
																			 Reg.Completo:='No';
																			 gotoxy(30,15);
																			 writeln(Reg.Completo);
																		end;
																	else
																		begin
																			 gotoxy(20,22);
																			 textcolor(red);
																			 writeln(#7'Tecla no válida. Vuelva a intentar.');
																			 textcolor(white);
																		end;
															   end;
														 until (Reg.Completo = 'Si') or (Reg.Completo = 'No');
														 gotoxy(20,22);
														 writeln('                                                             ');
														 repeat
															   gotoxy(40,16);
															   writeln('                        ');
															   gotoxy(40,16);
															   {$I-}
																	readln(Reg.Cant_Partes);
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
														 gotoxy(20,22);
														 writeln('                                                        ');
													end;
									   Reg.Estado_Obra := true;
									   Guardar_Obra(Arch, Nom_Arch, Reg);
									   gotoxy(25,22);
									   textcolor(green);
									   writeln('La obra ha sido dada de alta');
									   textcolor(white);
									   readkey;
								  end
									 else
										 begin
											  gotoxy(12,22);
											  textcolor(red);
											  writeln(#7'El museo ha sido dado de baja. Dar de alta para continuar.');
											  textcolor(white);
											  readkey;
										 end;
							 end
							   else
								   begin
										gotoxy(15,22);
										textcolor(red);
										writeln(#7'El museo no existe. Registre el museo para continuar.');
										textcolor(white);
										readkey;
								   end;
					 end
						else
							begin
								 gotoxy(12,22);
								 textcolor(red);
								 writeln(#7'El artista ha sido dado de baja. Dar de alta para continuar.');
								 textcolor(white);
								 readkey;							 
							end;
				  end
					 else
						 begin
							  gotoxy(15,22);
							  textcolor(red);
							  writeln(#7'El artista no existe. Registre el artista para continuar.');
							  textcolor(white);
							  readkey;
						 end;
		  end
			 else
				 begin
					  Leer_Obra(Arch, Nom_Arch, Posi, Reg);
					  if (Reg.Estado_Obra) then
						 begin
							  repeat 
									clrscr;
									textcolor(6);
									x:=12;
									y:=2;
									for i:=1 to 19 do //izq
										begin
											gotoxy(x,y);
											writeln('*');
											inc(y);
										end;
									x:=12;
									y:=2;
									for i:=1 to 29 do //arriba
										begin
											gotoxy(x,y);
											writeln('*');
											x:=x+2
										end;
									x:=70;
									y:=2;
									for i:=1 to 19 do //der
										begin
											gotoxy(x,y);
											writeln('*');
											inc(y);
										end;
									x:=12;
									y:=20;
									for i:=1 to 29 do //abajo
										begin
											gotoxy(x,y);
											writeln('*');
											x:=x+2
										end;
							        textcolor(white);
									gotoxy(17,6);
									writeln('Esta obra ya esta registrada. Que desea hacer?');
									gotoxy(34,10);
									writeln('1) Modificar');
									gotoxy(34,12);
									writeln('2) Dar baja');
									gotoxy(34,14);
									writeln('ESC) Volver');
									Control:=readkey;
									keypressed;
									if (Control = '1') then
									   Modificar_Obra(Arch, Arch_Art ,Arch_Mus,Nom_Arch, Nom_Arch_Art, Nom_Arch_Mus, Posi)
										  else
											  if (Control = '2') then
												 begin
													  Baja_Obra(Arch, Nom_Arch, Posi);
													  gotoxy(25,22);
													  textcolor(green);
													  writeln('La obra ha sido dada de baja');
													  textcolor(white);
													  readkey;
												 end
												 else
													 if (Control = #27) then
														clrscr
														   else
															   begin
																	gotoxy(20,22);
																	textcolor(red);
																	writeln(#7'Tecla no válida. Vuelva a intentar.');
																	textcolor(white);
																	readkey;
															   end;
							  until (control = '1') or (control='2') or (control = #27);
						 end
							else
							begin
								repeat
										clrscr;
										textcolor(6);
										x:=12;
										y:=2;
										for i:=1 to 19 do //izq
											begin
												gotoxy(x,y);
												writeln('*');
												inc(y);
											end;
										x:=12;
										y:=2;
										for i:=1 to 29 do //arriba
											begin
												gotoxy(x,y);
												writeln('*');
												x:=x+2
											end;
										x:=70;
										y:=2;
										for i:=1 to 19 do //der
											begin
												gotoxy(x,y);
												writeln('*');
												inc(y);
											end;
										x:=12;
										y:=20;
										for i:=1 to 29 do //abajo
											begin
												gotoxy(x,y);
												writeln('*');
												x:=x+2
											end;
									  textcolor(red);
									  gotoxy(16,6);
									  writeln('Esta obra esta registrada pero esta dada de baja');
									  textcolor(white);
									  gotoxy(34,10);
									  writeln('1) Dar de alta');
									  gotoxy(34,13);
									  writeln('ESC) Volver');
									  Control:=readkey;
									  keypressed;
									  if (Control = '1') then
										 begin
											  Alta_Estado_Obra(Arch, Nom_Arch, Posi);
											  gotoxy(25,22);
											  textcolor(green);
											  writeln('La obra ha sido dada de alta');
											  textcolor(white);
											  readkey;
										 end
											else
												if (control = #27) then
												   clrscr
													  else
														  begin
															   textcolor(red);
															   writeln(#7'Tecla no válida. Vuelva a intentar.');
															   textcolor(white);
															   readkey;
														  end;
								until (control = '1') or (control = #27);
							end;
				 end;
	end;

procedure Baja_Obra(var Arch:T_Obras; Nom_Arch:string; var Pos:integer);
	var
		Reg:R_Obras;
	begin
	   Leer_Obra(Arch, Nom_Arch, Pos, Reg);
	   Reg.Estado_Obra:=false;
	   Abrir_Obra(Arch, Nom_Arch);
	   seek(Arch, Pos);
	   write(Arch, Reg);
	   close(Arch);
	end;

procedure Alta_Estado_Obra(var Arch:T_Obras; Nom_Arch:string; var Pos:integer);
	var
		Reg:R_Obras;
	begin
	   Leer_Obra(Arch, Nom_Arch, Pos, Reg);
	   Reg.Estado_Obra:=true;
	   Abrir_Obra(Arch, Nom_Arch);
	   seek(Arch, Pos);
	   write(Arch, Reg);
	   close(Arch);
	end;

procedure Eliminar_Obra(var Arch:T_Obras);
	begin
	   erase(Arch);
	end;

procedure Busqueda_Nombre_Obra(var Arch:T_Obras; Nom_Arch:string; Busc:st30; var Pos:integer);
	var
		Reg_Aux:R_Obras;
		i:integer;
	begin
	   i:=0;
	   Pos := -1;
	   Abrir_Obra(Arch, Nom_Arch);
	   while not eof(Arch) do
	   begin
			read(Arch, Reg_Aux);
			if Reg_Aux.Nom_Obra = Busc then
			   begin
					pos:=i;
			   end;
			i:=i+1;
			seek(Arch, i);
	   end;
	   close(Arch);
	end;

procedure Busqueda_Codigo_Obra(var Arch:T_Obras; Nom_Arch:string; Busc:integer; var Pos:integer);
	var
		Reg_Aux:R_Obras;
		i:integer;
	begin
	   i:=0;
	   Pos := -1;
	   Abrir_Obra(Arch, Nom_Arch);
	   while not eof(Arch) do
	   begin
			read(Arch, Reg_Aux);
			if Reg_Aux.Cod_Obra = Busc then
			   begin
					Pos:=i;
			   end;
			i:=i+1;
			seek(Arch, i);
	   end;
	   close(Arch);
	end;

procedure Busqueda_Consulta_Artista(var Arch:T_Obras; Nom_Arch:string; Busc:integer; var Pos:integer); // LISTO
	var
		Reg_Aux:R_Obras;
		i,y,z,x:integer;
	begin
	   y:=6;
	   i:=0;
	   Pos:=-1;
	   gotoxy(25,6);
	   writeln('Obras: ');
	   Abrir_Obra(Arch, Nom_Arch);
	   while not eof(Arch) do
	   begin
			read(Arch, Reg_Aux);
			if Reg_Aux.DNI_Artista = Busc then
			   begin
					Pos:=1;
					if Reg_Aux.Estado_Obra then
					   begin
							gotoxy(34,y);
							writeln('* ', Reg_Aux.Nom_Obra);
							Pos:=1;
							y:=y+1;
					   end;
			   end;
			i:=i+1;
			seek(Arch, i);
	   end;
	   textcolor(6);
	   x:=22;
	   z:=3;
	   for i:=1 to y+1 do //izq
		   begin
				gotoxy(x,z);
				writeln('|');
				inc(z);
		   end;
	   x:=23;
	   z:=y+3;
	   for i:=1 to 19 do //abajo
		   begin
				gotoxy(x,z);
				writeln('_');
				x:=x+2
		   end;
	   x:=60;
	   z:=3;
	   for i:=1 to y+1 do //der 
		   begin
				gotoxy(x,z);
				writeln('|');
				inc(z);
		   end;
	   x:=23;
	   z:=2;
	   for i:=1 to 19 do //arriba
		   begin
				gotoxy(x,z);
				writeln('_');
				x:=x+2
		   end;
	   close(Arch);
	   textcolor(black);
	   textbackground(6);
	   gotoxy(24,y+6);
	   writeln('Presione cualquier tecla para salir.');
	   textbackground(black);
	   textcolor(white);
	   readkey;
	end;

	procedure Busqueda_Consulta_Museo(var Arch:T_Obras; Nom_Arch:string; Busc:integer; var Pos:integer);
	var
		Reg_Aux:R_Obras;
		i,y,x,z:integer;
	begin
	   y:=7;
	   i:=0;
	   Pos:=-1;
	   gotoxy(25,7);
	   writeln('Obras: ');
	   Abrir_Obra(Arch, Nom_Arch);
	   while not eof(Arch) do
	   begin
			read(Arch, Reg_Aux);
			if Reg_Aux.Cod_Museo = Busc then
			   begin
					if Reg_Aux.Estado_Obra then
					begin
						 gotoxy(32,y);
						 writeln('* ', Reg_Aux.Nom_Obra);
						 Pos:=1;
						 y:=y+1;
					end;
			   end;
		   i:=i+1;
		   seek(Arch, i);
	   end;
	   textcolor(6);
	   x:=22;
	   z:=2;
	   for i:=1 to y+1 do //izq
		   begin
				gotoxy(x,z);
				writeln('|');
				inc(z);
		   end;
	   x:=23;
	   z:=y+2;
	   for i:=1 to 19 do //abajo
		   begin
				gotoxy(x,z);
				writeln('_');
				x:=x+2
		   end;
	   x:=60;
	   z:=2;
	   for i:=1 to y+1 do //der 
		   begin
				gotoxy(x,z);
				writeln('|');
				inc(z);
		   end;
	   x:=23;
	   z:=1;
	   for i:=1 to 19 do //arriba
		   begin
				gotoxy(x,z);
				writeln('_');
				x:=x+2
		   end;
	   close(Arch);
	   textcolor(black);
	   textbackground(6);
	   gotoxy(24,y+6);
	   writeln('Presione cualquier tecla para salir.');
	   textbackground(black);
	   textcolor(white);
	   readkey;
	end;

procedure Estadistica_Museo(var Arch:T_Obras; Nom_Arch:string; Busc:integer; var Pos:integer);
	var
		Reg_Aux:R_Obras;
		i,x,y:integer;
		Cant_E:integer;
		Cant_F:integer;
		Cant_P:integer;
		Cant_O:integer;
		Por_E:real;
		Por_F:real;
		Por_P:real;
	begin
	   i:=0;
	   Cant_E:=0;
	   Cant_F:=0;
	   Cant_P:=0;
	   Cant_O:=0;
	   Pos:=-1;
	   Abrir_Obra(Arch, Nom_Arch);
	   while not eof(Arch) do
	   begin
			read(Arch, Reg_Aux);
			if Reg_Aux.Cod_Museo = Busc then
			   begin
					if Reg_Aux.Estado_Obra then
					begin
						 Pos:=1;
						 Cant_O:=Cant_O+1;
						 if (Reg_Aux.Tipo='Pintura') then
							Cant_P:=Cant_P+1
							else
							if (Reg_Aux.Tipo='Estatua') then
							   Cant_E:=Cant_E+1
							   else
								   Cant_F:=Cant_F+1;
			        end;
			   end;
			i:=i+1;
			seek(Arch, i);
	    end;
	    if Pos=1 then
		begin
			   textcolor(11);
			   x:=20;
			   y:=3;
			   for i:=1 to 10 do //izq -
				   begin
						gotoxy(x,y);
						writeln('|');
						inc(y);
				   end;
			   x:=21;
			   y:=12;
			   for i:=1 to 20 do // abajo -
				   begin
						gotoxy(x,y);
						writeln('_');
						x:=x+2
				   end;
			   x:=60;
			   y:=3;
			   for i:=1 to 10 do // der -
				   begin
						gotoxy(x,y);
						writeln('|');
						inc(y);
				   end;
			   x:=21;
			   y:=2;
			   for i:=1 to 20 do // arriba -
			   begin
					gotoxy(x,y);
					writeln('_');
					x:=x+2
			   end;
			   textcolor(13);
			   x:=17;
			   y:=2;
			   for i:=1 to 12 do //izq +
				   begin
						gotoxy(x,y);
						writeln('|');
						inc(y);
				   end;
			   x:=18;
			   y:=13;
			   for i:=1 to 23 do // abajo +
				   begin
						gotoxy(x,y);
						writeln('_');
						x:=x+2
				   end;
			   x:=63;
			   y:=2;
			   for i:=1 to 12 do // der +
				   begin
						gotoxy(x,y);
						writeln('|');
						inc(y);
				   end;
			   x:=18;
			   y:=1;
			   for i:=1 to 23 do // arriba +
			   begin
					gotoxy(x,y);
					writeln('_');
					x:=x+2
			   end;
			   textcolor(white);
			   Por_E:=(100*Cant_E)div Cant_O;
			   Por_F:=(100*Cant_F)div Cant_O;
			   Por_P:=(100*Cant_P)div Cant_O;
			   gotoxy(28,9);
			   writeln('OBRAS:');
			   gotoxy(35,8);
			   writeln('Estatuas: ', Por_E:2:0,'%');
			   gotoxy(35,9);
			   writeln('Fosiles: ', Por_F:2:0,'%');
			   gotoxy(35,10);
			   writeln('Pinturas: ', Por_P:2:0,'%');
		end
		else
			begin
				textcolor(red);
				x:=20;
				y:=3;
				for i:=1 to 10 do //izq -
				begin
					gotoxy(x,y);
					writeln('|');
					inc(y);
				end;
				x:=21;
				y:=12;
				for i:=1 to 20 do // abajo -
				begin
					gotoxy(x,y);
					writeln('_');
					x:=x+2
				end;
				x:=60;
				y:=3;
				for i:=1 to 10 do // der -
				begin
					gotoxy(x,y);
					writeln('|');
					inc(y);
				end;
				x:=21;
				y:=2;
				for i:=1 to 20 do // arriba -
				begin
				gotoxy(x,y);
				writeln('_');
				x:=x+2
				end;
				textbackground(red);
				textcolor(white);
				gotoxy(22,8);
				writeln(#7'Este museo no tiene obras registradas.');
			end;
	   close(Arch);
	end;

begin	
end.
