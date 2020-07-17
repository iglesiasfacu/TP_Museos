unit Vector_Directores;

interface

uses crt, Archivo_Directores;

const
	N = 1000;

type
	R_Vec_Dir = record
		Campo:string;
		Pos_Arch: integer;
		end;
	
	V_Directores = array[1..N] of R_Vec_Dir;

procedure Inicializar_Vector_Director(var Vec:V_Directores);
procedure Ordenar_ApNom_Director(var Arch:T_Directores; Nom_Arch:string; var Vec:V_Directores);
procedure Listado_Director(var Arch:T_Directores ; Nom_Arch:string; Vec:V_Directores);


implementation

procedure Inicializar_Vector_Director(var Vec:V_Directores);
    var
       i:integer;
       Reg:R_Vec_Dir;
    begin
         Reg.Campo:='';
         Reg.Pos_Arch:=0;
         for i:=1 to N do
         begin
              Vec[i]:=Reg;
         end;
    end;

procedure Ordenar_ApNom_Director(var Arch:T_Directores; Nom_Arch:string; var Vec:V_Directores);
    var
       Reg:R_Directores;
       Reg_Aux:R_Vec_Dir;
       Pos,i,j,Lim:integer;
    begin
         Pos:=0;
         Abrir_Director(Arch, Nom_Arch);
         Lim:=filesize(Arch); // tamaño archivo
         close(Arch);
         for i:=1 to Lim do
             begin
                  Leer_Director(Arch, Nom_Arch, Pos, Reg);
                  with Vec[i] do
                       begin
                            Campo:=Reg.ApNom_Dir;
                            Pos_Arch:=Pos;
                       end;
                  inc(Pos);
             end;

         for i:=1 to Lim-1 do
             begin
                  for j:=1 to Lim-i do
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
    
procedure Listado_Director(var Arch:T_Directores ; Nom_Arch:string; Vec:V_Directores);
	var
	Reg:R_Directores;
	Lim,i,j,y,z:integer;
	Control:char;
	begin
	z:=4;
	Ordenar_ApNom_Director(Arch, Nom_Arch, Vec);
	Abrir_Director(Arch, Nom_Arch);
	Lim:=filesize(Arch);
	close(Arch);
	textcolor(yellow);
	gotoxy(10,1);
	writeln('Listado de los directores ordenados alfabeticamente por nombre');
	gotoxy(1,3);
	writeln(' Nombre del Director |    DNI    |   Direccion   |  Telefono  | Periodo en años ');
	gotoxy(1,4);
	writeln('________________________________________________________________________________');
	for i:=1 to Lim do
	begin
		if (i mod 8)<>0 then
		   begin
				with Vec[i] do
					 begin
						  Leer_Director(Arch, Nom_Arch, Pos_Arch, Reg);
					 end;
				if (Reg.Estado_Dir) then
				   begin
						inc(z);
						textcolor(white);
						gotoxy(2,z);
						writeln(Reg.ApNom_Dir);
						gotoxy(24,z);
						writeln(Reg.DNI_Dir);
						gotoxy(35,z);
						writeln(Reg.Direc_Dir);
						gotoxy(52,z);
						writeln(Reg.Tel_Dir);
						gotoxy(68,z);
						writeln(Reg.Per_Des);
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
								 Leer_Director(Arch, Nom_Arch, Pos_Arch, Reg);
							end;
					   if (Reg.Estado_Dir) then
						  begin
							   inc(z);
							   textcolor(white);
							   gotoxy(2,z);
							   writeln(Reg.ApNom_Dir);
							   gotoxy(24,z);
							   writeln(Reg.Direc_Dir);
							   gotoxy(35,z);
							   writeln(Reg.DNI_Dir);
							   gotoxy(52,z);
							   writeln(Reg.Tel_Dir);
							   gotoxy(68,z);
							   writeln(Reg.Per_Des);
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
												y:=5;
												for j:=1 to 14 do
													begin
														 gotoxy(1,y);
														 writeln('                                                                                                                                                       ');
														 writeln('                                                                                                                                                       ');
														 y:=y+2;
													end;
												z:=4;
												gotoxy(10,1);
												writeln('Listado de los directores ordenados alfabeticamente por nombre');
												gotoxy(1,3);
												writeln(' Nombre del Director |    DNI    |   Direccion   |  Telefono  | Periodo en años ');
												gotoxy(1,4); 				  
												writeln('________________________________________________________________________________');
										   end;
									   #27:begin
												exit;
										   end;
									   end;
							until (Control='s') or (Control=#27);
			   end;
			   if i=Lim then
				  begin
					   textcolor(yellow);
					   writeln('ESC) Volver al Menu Principal');
					   textcolor(white);					   
					   gotoxy(1,1);
					   repeat
							 Control:=readkey;
							 case Control of
							     #27:begin
										 exit;
									 end;
							   end;
					until (Control='a') or (Control=#27);
				    end;
		   end;
	end;
   
begin
end.
