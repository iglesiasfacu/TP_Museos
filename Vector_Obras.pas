unit Vector_Obras;

interface

uses crt, Archivo_Obras;

const
	N=1000;

type
	R_Vec_Obras = record
		Campo:string;
		Pos_Arch:integer;
		end;
		
    V_Obras = array[1..N] of R_Vec_Obras;
    
    procedure Inicializar_Vector_Obra(var Vec:V_Obras);
    procedure Ordenar_Nombre_Obras(var Arch:T_Obras; Nom_Arch:string; var Vec:V_obras);
    procedure Listado_Obra(var Arch:T_Obras ; Nom_Arch:string; Vec:V_Obras);


implementation


procedure Inicializar_Vector_Obra(var Vec:V_Obras);
    var
       i:integer;
       Reg:R_Vec_Obras;
    begin
         Reg.Campo:='';
         Reg.Pos_Arch:=0;
         for i:=1 to N do
         begin
              Vec[i]:=reg;
         end;
    end;
    
procedure Ordenar_Nombre_Obras(var Arch:T_Obras; Nom_Arch:string; var Vec:V_obras);
    var
       Reg:R_Obras;
       Reg_Aux:R_Vec_Obras;
       Pos,i,j,Lim:integer;
    begin
         Pos:=0;
         Abrir_Obra(Arch, Nom_Arch);
         Lim:=filesize(Arch);
         close(Arch);
         for i:=1 to Lim do
             begin
                  Leer_Obra(Arch, Nom_Arch, Pos, Reg);
                  with Vec[i] do
                       begin
                            Campo:=Reg.Nom_Obra;
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

procedure Listado_Obra(var Arch:T_Obras ; Nom_Arch:string; Vec:V_Obras);
	var	
		Reg:R_Obras;
		Lim,i,y,j,z:integer;
		Control:char;
	begin
	   z:=4; //valor de la y en gotoxy
	   Ordenar_Nombre_Obras(Arch, Nom_Arch, Vec);
	   Abrir_Obra(Arch, Nom_Arch);
	   Lim:=filesize(Arch);
	   close(Arch);
	   textcolor(yellow);
	   gotoxy(10,1);
	   writeln('Listado de las obras ordenadas alfabeticamente por nombre');
	   gotoxy(1,3);
	   writeln('Nombre de la obra | Codigo | DNI Art |  Tipo  | Altura | Peso | Compl | C.Partes');
	   gotoxy(1,4);
	   writeln('________________________________________________________________________________');
	   for i:=1 to Lim do
	   begin
			if (i mod 8)<> 0 then
			   begin
					with Vec[i] do
						 begin
							  Leer_Obra(Arch, Nom_Arch, Pos_Arch, Reg);
						 end;
						 if Reg.Estado_Obra then
							begin
								inc(z);
								textcolor(white);
								gotoxy(2,z);
								writeln(Reg.Nom_Obra);
								gotoxy(21,z);
								writeln(Reg.Cod_Obra);
								gotoxy(29,z);
								writeln(Reg.DNI_Artista);
								gotoxy(39,z);
								writeln(Reg.Tipo);
								if Reg.Tipo='Estatua' then
									begin
										gotoxy(49,z);
										writeln(Reg.Altura :2:2);
										gotoxy(57,z);
										writeln(Reg.Peso:2:2);
										gotoxy(67,z);
										writeln('-');
										gotoxy(77,z);
										writeln('-');
									end;
									if Reg.Tipo='Fosil' then
										begin
										if Reg.completo='Si' then
											begin
												gotoxy(67,z);
												writeln('Si')
											end
											else
											begin
												gotoxy(67,z);
												writeln('No');
											end;
											gotoxy(75,z);
											writeln(Reg.Cant_Partes);
											gotoxy(51,z);
											writeln('-');
											gotoxy(60,z);
											writeln('-');
										end;
									if Reg.Tipo='Pintura' then
										begin
											gotoxy(51,z);
											writeln('-');
											gotoxy(60,z);
											writeln('-');
											gotoxy(67,z);
											writeln('-');
											gotoxy(77,z);
											writeln('-');
										end;
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
							  Leer_Obra(Arch, Nom_Arch, Pos_Arch, Reg);
						   end;
						   if Reg.Estado_Obra then
							  begin
								   inc(z);
								   textcolor(white);
								   gotoxy(2,z);
								   writeln(Reg.Nom_Obra);
								   gotoxy(21,z);
								   writeln(Reg.Cod_Obra);
								   gotoxy(29,z);
								   writeln(Reg.DNI_Artista);
								   gotoxy(39,z);
								   writeln(Reg.Tipo);
								   if Reg.Tipo = 'Estatua' then
									begin
										gotoxy(49,z);
										writeln(Reg.Altura :2:2);
										gotoxy(57,z);
										writeln(Reg.Peso:2:2);
										gotoxy(67,z);
										writeln('-');
										gotoxy(77,z);
										writeln('-');
									end;
									if Reg.Tipo='Fosil' then
										begin
										if Reg.completo='Si' then
											begin
												gotoxy(67,z);
												writeln('Si')
											end
											else
											begin
												gotoxy(67,z);
												writeln('No');
											end;
											gotoxy(75,z);
											writeln(Reg.Cant_Partes);
											gotoxy(51,z);
											writeln('-');
											gotoxy(60,z);
											writeln('-');
										end;
										if Reg.Tipo='Pintura' then
										begin
											gotoxy(51,z);
											writeln('-');
											gotoxy(60,z);
											writeln('-');
											gotoxy(67,z);
											writeln('-');
											gotoxy(77,z);
											writeln('-');
										end;
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
													writeln('Listado de las obras ordenadas alfabeticamente por nombre');
												    gotoxy(1,3);
												    writeln('Nombre de la obra | Codigo | DNI Art |  Tipo  | Altura | Peso | Compl | C.Partes');
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
