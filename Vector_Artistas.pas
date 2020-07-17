unit Vector_Artistas;

interface

uses crt, Archivo_Artistas;

const
	N = 1000;

type
	R_Vec_Art = record
		Campo:string; // nombre
		Pos_Arch: integer; // pos en el vec
		end;
	
	V_Artistas = array[1..N] of R_Vec_Art; // se usara este vector para los listados
	
	procedure Inicializar_Vector_Artista(var Vec:V_Artistas);
	procedure Ordenar_ApNom_Artista(var Arch:T_Artistas; Nom_Arch:string; var Vec:V_Artistas);
	procedure Listado_Artista(var Arch:T_Artistas ; Nom_Arch:string; Vec:V_Artistas);
	

implementation

procedure Inicializar_Vector_Artista(var Vec:V_Artistas);
    var
       i:integer;
       Reg:R_Vec_Art;
    begin
         Reg.Campo:='';
         Reg.Pos_Arch:=0;
         for i:=1 to N do
         begin
              Vec[i]:=Reg;
         end;
    end;

procedure Ordenar_ApNom_Artista(var Arch:T_Artistas; Nom_Arch:string; var Vec:V_Artistas);
    var
       Reg:R_Artistas;
       Reg_Aux:R_Vec_Art;
       Pos,i,j,Lim:integer;
    begin
         Pos:=0;
         Abrir_Artista(Arch, Nom_Arch);
         Lim:=filesize(Arch); // tamaño del archivo
         close(Arch);
         for i:=1 to Lim do
             begin
                  Leer_Artista(Arch, Nom_Arch, Pos, Reg);
                  with Vec[i] do
                       begin
                            Campo:=Reg.ApNom_Artista;
                            Pos_Arch:=Pos;
                       end;
                  inc(Pos);
             end;

         for i:=1 to Lim-1 do // repeticiones del vector
             begin
                  for j:=1 to Lim-i do // comparaciones de elementos
                      begin
                           if Vec[j].Campo > Vec[j+1].Campo then
                              begin
                                   Reg_Aux:=Vec[j];
                                   Vec[j]:=Vec[j+1];
                                   Vec[j+1]:=Reg_Aux;
                              end;
                      end;
             end;
    end;

procedure Listado_Artista(var Arch:T_Artistas ; Nom_Arch:string; Vec:V_Artistas);
	var
		Reg:R_Artistas;
		Lim,i,j,y,z:integer;
		Control:char;
	begin
	z:=4; // incrementa espacios para nuevos datos
	Ordenar_ApNom_Artista(Arch, Nom_Arch, Vec); // ordena artistas por nombre
	Abrir_Artista(Arch, Nom_Arch);
	Lim:=filesize(Arch); // tamanio de archivo
	close(Arch);
	textcolor(yellow);
	gotoxy(10,1);
	writeln('Listado de los artistas ordenados alfabeticamente por nombre');
	gotoxy(1,3);
	writeln(' Nombre y Apellido |    DNI    |     Direccion     |    Ciudad    |     Pais    ');
	gotoxy(1,4); 				  
	writeln('________________________________________________________________________________');
	for i:=1 to Lim do // cicla hasta la cantidad de datos (filesize)
	begin
		if (i mod 8)<>0 then // si el modulo == 0 es porque llego al limite de filas
		begin
			 with Vec[i] do // con cada posicion del vector muestra datos
				  begin
					   Leer_Artista(Arch, Nom_Arch, Pos_Arch, Reg);
				  end;
				  if (Reg.Estado_Artista) then;
					 begin
						  inc(z);
						  textcolor(white);
						  gotoxy(2,z);
						  writeln(Reg.ApNom_Artista);
						  gotoxy(21,z);
						  writeln(Reg.DNI_Artista);
						  gotoxy(35,z);
						  writeln(Reg.Direc_Artista);
						  gotoxy(54,z);
						  writeln(Reg.Ciudad_Artista);
						  gotoxy(69,z);
						  writeln(Reg.Pais_Artista);
						  inc(z);
						  textcolor(yellow);
						  gotoxy(1,z);
						  writeln('________________________________________________________________________________');
					 end;
		end
		   else
			   begin
					with Vec[i] do
						 begin
							  Leer_Artista(Arch, Nom_Arch, Pos_Arch, Reg);
						 end;
						 if (Reg.Estado_Artista) then;
							begin
								 inc(z);
								 textcolor(white);
								 gotoxy(2,z);
								 writeln(Reg.ApNom_Artista);
								 gotoxy(21,z);
								 writeln(Reg.DNI_Artista);
								 gotoxy(33,z);
								 writeln(Reg.Direc_Artista);
								 gotoxy(54,z);
								 writeln(Reg.Ciudad_Artista);
								 gotoxy(69,z);
								 writeln(Reg.Pais_Artista);
								 inc(z);
								 textcolor(yellow);
								 gotoxy(1,z);
								 writeln('________________________________________________________________________________');
							end;
				            writeln('s: Siguiente página | ESC: Volver al Menu Principal');
							gotoxy(1,1);
							repeat
								  Control:=readkey;
								  keypressed;
								  case Control of
									   's':begin
												y:=5; // en la pos 5 del gotoxy y
												for j:=1 to 14 do // crea 14 espacios en blanco para paginacion
													begin
														 gotoxy(1,y);
														 writeln('                                                                                                                                                       ');
														 writeln('                                                                                                                                                       ');
														 y:=y+2; // incremeneta las filas para paginacion
													end;
												z:=4; // desde aca se empiezan a imprimir los datos
												gotoxy(10,1);
												writeln('Listado de los artistas ordenados alfabeticamente por nombre');
												gotoxy(1,3);
												writeln(' Nombre y Apellido |    DNI    |     Direccion     |    Ciudad    |     Pais    ');
												gotoxy(1,4); 				  
												writeln('________________________________________________________________________________');
										   end;
									   #27:begin
												exit;
										   end;
									   end;
							until (Control='s') or (Control=#27);
			   end;
			   if i=Lim then // si el ciclo for i llega al fin del archivo..
				  begin
					   textcolor(yellow);
					   writeln('ESC) Volver al Menu Principal');
					   textcolor(white);					   
					   gotoxy(1,1);
					   repeat
							 Control:=readkey;
							 case Control of
							     #27:begin
										 exit; // se vuelve al menu princpial
									 end;
							   end;
					until (Control='a') or (Control=#27);
				    end;
		   end;
	end;

begin
end.
