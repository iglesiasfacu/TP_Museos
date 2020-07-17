unit Vector_Museos;

interface

uses crt, Archivo_Museos;

const
	N = 1000;

type
	R_Vec_Museos = record
		Campo:string;
		Pos_Arch: integer;
		end;
	
	V_Museos = array [1..N] of R_Vec_Museos;
	
	procedure Inicializar_Vector_Museo(var Vec:V_Museos);
	procedure Ordenar_Nombre_Museo(var Arch:T_Museos; Nom_Arch:string; var Vec:V_Museos);
	procedure Listado_Museo(var Arch:T_Museos ; Nom_Arch:string; Vec:V_Museos);

implementation

procedure Inicializar_Vector_Museo(var Vec:V_Museos);
    var
       i:integer;
       Reg:R_Vec_Museos;
    begin
         Reg.Campo:='';
         Reg.Pos_Arch:=0;
         for i:=1 to N do
         begin
              Vec[i]:=Reg;
         end;
    end;

procedure Ordenar_Nombre_Museo(var Arch:T_Museos; Nom_Arch:string; var Vec:V_Museos);
    var
       Reg:R_Museos;
       Reg_Aux:R_Vec_Museos;
       Pos,i,j,Lim:integer;
    begin
         Pos:=0;
         Abrir_Museo(Arch, Nom_Arch);
         Lim:=filesize(Arch);
         close(Arch);
         for i:=1 to Lim do
             begin
                  Leer_Museo(Arch, Nom_Arch, Pos, Reg);
                  with Vec[i] do
                       begin
                            Campo:=Reg.Nom_Museo;
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

procedure Listado_Museo(var Arch:T_Museos ; Nom_Arch:string; Vec:V_Museos);
	var
		Reg:R_Museos;
		Lim,i,j,y,z:integer;
		Control:char;
	begin
	   z:=4;
	   Ordenar_Nombre_Museo(Arch, Nom_arch, Vec);
	   Abrir_Museo(Arch, Nom_Arch);
	   Lim:=filesize(Arch);
	   close(Arch);
	   textcolor(yellow);
	   gotoxy(10,1);
	   writeln('Listado de los museos ordenados alfabeticamente por nombre');
	   gotoxy(1,3);
	   writeln(' Nombre del museo  | Codigo |  DNI Director |    Pais    |   Ciudad   |   Tel.  ');
	   gotoxy(1,4);
	   writeln('________________________________________________________________________________');
	   for i:=1 to Lim do
	   begin
			if (i mod 8)<>0 then
			   begin
					with Vec[i] do
						 begin
							  Leer_Museo(Arch, Nom_Arch, Pos_Arch, Reg);
						 end;
					if (Reg.Estado_Museo) then
					   begin
							inc(z);
							textcolor(white);
							gotoxy(2,z);
							writeln(Reg.Nom_Museo);
							gotoxy(23,z);
							writeln(Reg.Cod_Museo);
							gotoxy(34,z);
							writeln(Reg.DNI_Direc);
							gotoxy(46,z);
							writeln(Reg.Pais_Museo);
							gotoxy(59,z);
							writeln(Reg.Ciudad_Museo);
							gotoxy(72,z);
							writeln(Reg.Tel_Museo);
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
										Leer_Museo(Arch, Nom_Arch, Pos_Arch, Reg);
								   end;
							  if (Reg.Estado_Museo) then
								 begin
									  inc(z);
									  textcolor(white);
									  gotoxy(2,z);
									  writeln(Reg.Nom_Museo);
									  gotoxy(23,z);
									  writeln(Reg.Cod_Museo);
									  gotoxy(34,z);
									  writeln(Reg.DNI_Direc);
									  gotoxy(46,z);
									  writeln(Reg.Pais_Museo);
									  gotoxy(59,z);
									  writeln(Reg.Ciudad_Museo);
									  gotoxy(72,z);
									  writeln(Reg.Tel_Museo);
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
												writeln('Listado de los museos ordenados alfabeticamente por nombre');
											    gotoxy(1,3);
											    writeln(' Nombre del museo  | Codigo |  DNI Director |    Pais    |   Ciudad   |   Tel.  ');
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
