unit Menu_Pr;

interface

uses crt, Archivo_Artistas, Archivo_Directores, Archivo_Museos, Archivo_Obras, Vector_Artistas, Vector_Directores, Vector_Museos, Vector_Obras;
	
	procedure Menu_Principal;
	procedure Menu_ABMC;
	procedure Menu_Alta;
	procedure Menu_Baja;
	procedure Menu_Modificar;
	procedure Menu_Consultar;
	procedure Menu_Listado;
	procedure Consulta_Artista(var Arch_Artista:T_Artistas; var Arch_Obra:T_Obras; Nom_Art:string; Nom_Obr:string);
	procedure Consulta_Museo(var Arch_Director:T_Directores; var Arch_Museo:T_Museos; var Arch_Obra:T_Obras; Nom_Dir:string; Nom_Mus:string; Nom_Obr:string);
	procedure Consulta_Obra(var Arch_Artista:T_Artistas; var Arch_Museo:T_Museos; var Arch_Obra:T_Obras; Nom_Art:string; Nom_Mus:string; Nom_Obr:string);
	procedure Estadisticas(var Arch_Museo:T_Museos; var Arch_Obra:T_Obras; Nom_Mus:string; Nom_Obr:string);
	procedure Menu_Estadistica;

var

// archivos
Arch_Artista:T_Artistas;
Arch_Director:T_Directores;
Arch_Museo:T_Museos;
Arch_Obra:T_Obras;
Nom_Art:string;
Nom_Dir:string;
Nom_Mus:string;
Nom_Obr:string;


implementation

procedure Menu_Principal;
	var
		Control,Ctrl_Aux:char; // tecla ingresar menu
		x,y,i,j,color:integer; // parte grafica
	begin
	Abrir_Artista(Arch_Artista, Nom_Art);
	close(Arch_Artista);
	Abrir_Director(Arch_Director, Nom_Dir);
	close(Arch_Director);
	Abrir_Museo(Arch_Museo, Nom_Mus);
	close(Arch_Museo);
	Abrir_Obra(Arch_Obra, Nom_Obr);
	close(Arch_Obra);
	repeat
	clrscr;
	textcolor(green);
	color:=1; // inicializa el color en 1 para luego incrementarlo
	for j := 1 to 8 do
	x:=1;
	y:=2;
	for i := 1 to 22 do
	begin
		gotoxy(x,y);
		writeln('\\');
		inc(y);
		x:=x+1
	end;
	for j := 1 to 8 do
	x:=56;
	y:=23;
	for i := 1 to 22 do
	begin
		gotoxy(x,y);
		writeln('//');
		dec(y);
		x:=x+1
	end;
	
	gotoxy(5,22);
	writeln('© TP FINAL');
	gotoxy(4,23);
	writeln('PROGRAMACION ®');
	textcolor(white);
	gotoxy(1,25);
	writeln('█║▌│█│║▌║││█║▌║▌║');
	
	textbackground(15);
	textcolor(128);
	gotoxy(26,3);
	writeln('---------BIENVENIDO---------');
	textbackground(6);
	textcolor(0);
	gotoxy(23,6);
	writeln('1) Alta-Baja-Modificacion-Consulta');
	gotoxy(34,10);
	writeln('2) Listados');
	gotoxy(32,14);
	writeln('3) Estadisticas');
	gotoxy(30,18);
	writeln('4) Formatear Datos');
	gotoxy(35,22);
	writeln('5) Salir');
	repeat
	textcolor(white);
	textbackground(black);
	until keypressed=true; // repite hasta que se presione una tecla
	Control:=readkey; // la tecla presionada se asigna a control
	case Control of
		'1':begin
				clrscr;
			    Menu_ABMC;
		    end;

	    '2':begin
			    clrscr;
			    Menu_Listado
		    end;
	    '3':begin
			    clrscr;
			    Menu_Estadistica;
		    end;
	    '4':begin
				clrscr;
				textcolor(6);
				x:=19; // pos en x
				y:=7; // pos en y
				for i := 1 to 6 do // cantidad de lineas
				begin
					gotoxy(x,y); 
					writeln('|');
					inc(y);
				end;
				x:=39;
				y:=10;
				for i := 1 to 3 do //chiquito
				begin
					gotoxy(x,y);
					writeln('|');
					inc(y);
				end;
				x:=20;
				y:=9;
				for i := 1 to 20 do //medio
				begin
					gotoxy(x,y);
					writeln('_');
					x:=x+2
				end;
				x:=20;
				y:=12;
				for i := 1 to 20 do
				begin
					gotoxy(x,y);
					writeln('_');
					x:=x+2
				end;
				x:=59;
				y:=7;
				for i := 1 to 6 do
				begin
					gotoxy(x,y);
					writeln('|');
					inc(y);
				end;
				x:=20;
				y:=6;
				for i := 1 to 20 do
				begin
					gotoxy(x,y);
					writeln('_');
					x:=x+2
				end;
				textcolor(white);
				gotoxy(21,8);
				writeln('Seguro que desea formatear los datos?');
				textbackground(green);
				gotoxy(26,11);
				writeln('1) SI');
				textbackground(red);
				gotoxy(47,11);
				writeln('2) NO');
				textbackground(black);
				repeat
				until keypressed=true;
					Ctrl_Aux:=readkey;
					repeat
						if Ctrl_Aux='1' then
								begin
									Eliminar_Artista(Arch_Artista);
									Eliminar_Director(Arch_Director);
									Eliminar_Museo(Arch_Museo);
									Eliminar_Obra(Arch_Obra);						
									clrscr;
									gotoxy(24,8);
									writeln('Formateando, por favor espere...');
									delay(3000); // pausa la app
									clrscr;
									textbackground(green);
									gotoxy(3,8);
									writeln('Los archivos han sido formateados definitivamente. Presione cualquier tecla.');
									textbackground(black);
									readkey;
									clrscr;
									Menu_Principal;
								end;
						 if Ctrl_Aux='2' then
								begin
									clrscr;
									Menu_Principal;
								end;
					until (Ctrl_Aux='1') or (Ctrl_Aux='2');
					end;
				   '5':begin
							clrscr;
							textcolor(6);
							x:=19;
							y:=7;
							for i := 1 to 6 do
							begin
								gotoxy(x,y);
								writeln('|');
								inc(y);
							end;
							x:=39;
							y:=10;
							for i := 1 to 3 do //chiquito
							begin
								gotoxy(x,y);
								writeln('|');
								inc(y);
							end;
							x:=20;
							y:=9;
							for i := 1 to 20 do //medio
							begin
								gotoxy(x,y);
								writeln('_');
								x:=x+2
							end;
							x:=20;
							y:=12;
							for i := 1 to 20 do
							begin
								gotoxy(x,y);
								writeln('_');
								x:=x+2
							end;
							x:=59;
							y:=7;
							for i := 1 to 6 do
							begin
								gotoxy(x,y);
								writeln('|');
								inc(y);
							end;
							x:=20;
							y:=6;
							for i := 1 to 20 do
							begin
								gotoxy(x,y);
								writeln('_');
								x:=x+2
							end;
							textcolor(white);
							gotoxy(27,8);
							writeln('Desea salir del programa?');
							textbackground(green);
							gotoxy(26,11);
							writeln('1) SI');
							textbackground(red);
							gotoxy(47,11);
							writeln('2) NO');
							textbackground(black);
							repeat						
							until keypressed=true;
								Ctrl_Aux:=readkey;
								repeat
									if Ctrl_Aux='1' then
											begin
												clrscr;											
												textcolor(white);
												gotoxy(26,9);
												writeln('Diseñado por los alumnos:');
												gotoxy(24,13);
												writeln('Iglesias Facundo y Alcoba Joel');	
												repeat
												textcolor(color);
												x:=59;
												y:=7;
												for i:=1 to 10 do //izq
												begin
													gotoxy(x,y);
													writeln('|'); 
													inc(y);
													delay(10);
												end;
												x:=20;
												y:=16; 
												for i:=1 to 20 do //abajo
												begin
													gotoxy(x,y);
													writeln('_'); 
													x:=x+2;
													delay(10);
												end;
												x:=19;
												y:=16;
												for i:=1 to 10 do //der
												begin
													gotoxy(x,y);
													writeln('|');
													dec(y);
													delay(10);
												end;
												x:=58;
												y:=6;
												for i:=1 to 20 do //arriba
												begin
													gotoxy(x,y);
													writeln('_');
													x:=x-2;
													delay(10);
												end;
												inc(color);					
												until keypressed = true;
												halt; // detiene el programa
											end;
									if Ctrl_Aux='2' then
											begin
												clrscr;
												menu_principal;
											end;
									until (Ctrl_Aux='1') or (Ctrl_Aux='2');
							end;
						else
							clrscr;
							textbackground(red);
							gotoxy(20,10);
							writeln(#7'Tecla no válida. Vuelva a intentar.');
							textbackground(black);
							readkey;
							clrscr;
						end;
		until (control='1') or (control='2') or (control='3');
		readkey;
	end;

procedure Menu_ABMC;
	var
		Control:char;
		i,x,y:integer;
	begin
	clrscr;
	repeat
	textcolor(white);
	gotoxy(25,5);
	writeln('INGRESE UNA OPCION');
	gotoxy(30,10);
	writeln('1) Alta');
	gotoxy(30,12);
	writeln('2) Baja');
	gotoxy(30,14);
	writeln('3) Modificar');
	gotoxy(30,16);
	writeln('4) Consultar');
	gotoxy(30,18);
	writeln('5) Volver al menu principal');
	textcolor(6);
	x:=1;
	y:=2;
	for i:=1 to 21 do //izq
	begin
		gotoxy(x,y);
		writeln('#');
		inc(y);
	end;
	x:=1;
	y:=1;
	for i:=1 to 40 do //arriba
	begin
		gotoxy(x,y);
		writeln('#');
		x:=x+2
	end;
	x:=79;
	y:=2;
	for i:=1 to 21 do //der
	begin
		gotoxy(x,y);
		writeln('#');
		inc(y);
	end;
	x:=1;
	y:=23;
	for i:=1 to 40 do //abajo
	begin
		gotoxy(x,y);
		writeln('#');
		x:=x+2
	end;
	repeat
	textcolor(white);
	until (keypressed = true);
		Control:=readkey;
		case Control of
			'1':begin
				   textcolor(white);
				   clrscr;
				   Menu_Alta;
				end;
			'2':begin
				   textcolor(white);
				   clrscr;
				   Menu_Baja;
				end;
			'3':begin
				   textcolor(white);
				   clrscr;
				   Menu_Modificar;
				end;
			'4':begin
				   clrscr;
				   Menu_Consultar;
				end;
			'5':begin
				   textcolor(white);
				   clrscr;
				   Menu_Principal;
				end;
		else
			clrscr;
			textbackground(red);
			gotoxy(20,10);
			writeln(#7'Tecla no válida. Vuelva a intentar.');
			textbackground(black);
			readkey;
			clrscr;
		end;
		until (Control='1') or (Control='2') or (Control='3') or (Control='4') or (Control='5');
		readkey;
	end;

procedure Menu_Alta;
	var
		Control:char;
		Reg_Art:R_Artistas;
		Reg_Dir:R_Directores;
		Reg_Mus:R_Museos;
		Reg_Obr:R_Obras;
		i,x,y:integer;
	begin
	repeat
	textcolor(white);
	gotoxy(25,5);
	writeln('MENU ALTA:');
	gotoxy(30,10);
	writeln('1) Artista');
	gotoxy(30,12);
	writeln('2) Director');
	gotoxy(30,14);
	writeln('3) Museo');
	gotoxy(30,16);
	writeln('4) Obra');
	gotoxy(30,18);
	writeln('5) Volver atrás');
	textcolor(6);
	x:=1;
	y:=2;
	for i:=1 to 21 do //izq
	begin
		gotoxy(x,y);
		writeln('#');
		inc(y);
	end;
	x:=1;
	y:=1;
	for i:=1 to 40 do //arriba
	begin
		gotoxy(x,y);
		writeln('#');
		x:=x+2
	end;
	x:=79;
	y:=2;
	for i:=1 to 21 do //der
	begin
		gotoxy(x,y);
		writeln('#');
		inc(y);
	end;
	x:=1;
	y:=23;
	for i:=1 to 40 do //abajo
	begin
		gotoxy(x,y);
		writeln('#');
		x:=x+2
	end;
	repeat
	textcolor(white);
	Until (keypressed = true);
		Control:=readkey;
		case Control of
		'1':begin
			textcolor(white);
			clrscr;
			Alta_Artista(Arch_Artista, Nom_Art, Reg_Art);
			Menu_Principal;
			end;
		'2':begin
			textcolor(white);
			clrscr;
			Alta_Director(Arch_Director, Nom_Dir, Reg_Dir);
			Menu_Principal;
			end;
		'3':begin
			textcolor(white);
			clrscr;
			Alta_Museo(Arch_Museo, Arch_Director, Nom_Mus, Nom_Dir, Reg_Mus);
			Menu_Principal;
			end;
		'4':begin
			textcolor(white);
			clrscr;
			Alta_Obra(Arch_Obra, Arch_Artista, Arch_Museo, Nom_Mus, Nom_Art, Nom_Obr, Reg_Obr);
			Menu_Principal;
			end;
		'5':begin
			clrscr;
			Menu_ABMC;
			end;
	else
		clrscr;
		gotoxy(20,10);
		textbackground(red);
		writeln(#7'Tecla no válida. Vuelva a intentar.');
		textbackground(black);
		readkey;
		clrscr;
		end;
	until (Control='1') or (Control='2') or (Control='3') or (Control='4') or (Control='5');
	readkey;
	end;

procedure Menu_Baja;
	var
		Control:char;
		Clave:integer; // clave del record a buscar
		Pos:integer;
		Val,i,x,y:integer; // Val: validar la clave
	begin
	repeat
	textcolor(white);
	gotoxy(25,5);
	writeln('MENU BAJA:');
	gotoxy(30,10);
	writeln('1) Artista');
	gotoxy(30,12);
	writeln('2) Director');
	gotoxy(30,14);
	writeln('3) Museo');
	gotoxy(30,16);
	writeln('4) Obra');
	gotoxy(30,18);
	writeln('5) Volver atrás');
	textcolor(6);
	x:=1;
	y:=2;
	for i:=1 to 21 do //izq
	begin
		gotoxy(x,y);
		writeln('#');
		inc(y);
	end;
	x:=1;
	y:=1;
	for i:=1 to 40 do //arriba
	begin
		gotoxy(x,y);
		writeln('#');
		x:=x+2
	end;
	x:=79;
	y:=2;
	for i:=1 to 21 do //der
	begin
		gotoxy(x,y);
		writeln('#');
		inc(y);
	end;
	x:=1;
	y:=23;
	for i:=1 to 40 do //abajo
	begin
		gotoxy(x,y);
		writeln('#');
		x:=x+2
	end;
	repeat
	textcolor(white);
	until (keypressed = true);
		Control:=readkey;
		case Control of
		'1':begin
			textcolor(white);
			repeat
			clrscr;
			repeat
			writeln('Ingrese el DNI del artista que desea dar de baja: ');
				{$I-}
					readln(Clave);
				{$I+}
				Val:=ioresult(); // si ioresult = 0 se valida, si es <> 0 hay un error
				if Val<>0 then
					begin
						textbackground(red);
						writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
						textbackground(black);
					end;
			until Val=0;
			Busqueda_DNI_Artista(Arch_Artista, Nom_Art, Clave, Pos);
			if Pos>-1 then
				begin
					Baja_Artista(Arch_Artista, Nom_Art, Pos);
					textbackground(green);
					writeln('El artista ha sido dado de baja.');
					textbackground(black);
					readkey;
					Menu_ABMC;
				end
			else
				begin
					textbackground(red);
					writeln(#7'El artista no esta registrado. Dar de alta para continuar.');
					textbackground(black);
					readkey;
					Menu_ABMC;
				end;
			until Pos>-1
			end;		
			
		'2':begin
			textcolor(white);
			repeat
			clrscr;
			repeat
			writeln('Ingrese el DNI del director que desea dar de baja: ');
				{$I-}
					readln(Clave);
				{$I+}
				Val:=ioresult();
				if Val<>0 then
					begin
						textbackground(red);
						writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
						textbackground(black);
					end;
			until Val=0;
			Busqueda_DNI_Director(Arch_Director, Nom_Dir, Clave, Pos);
			if Pos>-1 then
				begin
					Baja_Director(Arch_Director, Nom_Dir, Pos);
					textbackground(green);
					writeln('El director ha sido dado de baja.');
					textbackground(black);
					readkey;
					Menu_ABMC;
				end
			else
				begin
					textbackground(red);
					writeln(#7'El director no esta registrado. Dar de alta para continuar.');
					textbackground(black);
					readkey;
					Menu_ABMC;
				end;
			until Pos>-1
			end;
			
		'3':begin
			textcolor(white);
			repeat
			clrscr;
			repeat
				writeln('Ingrese el codigo del museo que desea dar de baja: ');
				{$I-}
					readln(Clave);
				{$I+}
				Val:=ioresult();
				if Val<>0 then
					begin
						textbackground(red);
						writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
						textbackground(black);
					end;
			until Val=0;
			Busqueda_Codigo_Museo(Arch_Museo, Nom_Mus, Clave, Pos);
			if pos>-1 then
				begin
					Baja_Museo(Arch_Museo, Nom_Mus, Pos);
					textbackground(green);
					writeln('El museo ha sido dado de baja.');
					textbackground(black);
					readkey;
					Menu_ABMC;
				end
			else
				begin
					textbackground(red);
					writeln(#7'El museo no esta registrado. Dar de alta para continuar.');
					textbackground(black);
					readkey;
					Menu_ABMC;
				end;
		until Pos>-1
		end;
		
		'4':begin
			textcolor(white);
			repeat
			clrscr;
			repeat
			writeln('Ingrese el codigo de la obra que desea dar de baja: ');
				{$I-}
					readln(Clave);
				{$I+}
				Val:=ioresult();
				if Val<>0 then
					begin
						textbackground(red);
						writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
						textbackground(black);
					end;
				until Val=0;
				Busqueda_Codigo_Obra(Arch_Obra, Nom_Obr, Clave, Pos);
				if Pos>-1 then
					begin
						Baja_Obra(Arch_Obra, Nom_Obr, Pos);
						textbackground(green);
						writeln('La obra ha sido dada de baja.');
						textbackground(black);
						readkey;
						Menu_ABMC;
					end
				else
					begin
						textbackground(red);
						writeln(#7'La obra no esta registrada. Dar de alta para continuar.');
						textbackground(black);
						readkey;
						Menu_ABMC;
					end;
				until Pos>-1
				end;
				
		'5':begin
				clrscr;
				Menu_ABMC;
			end;
	else
		clrscr;
		gotoxy(20,10);
		textbackground(red);
		writeln(#7'Tecla no válida. Vuelva a intentar.');
		textbackground(black);
		readkey;
		clrscr;
	end;
		until (Control='1') or (Control='2') or (Control='3') or (Control='4') or (Control='5');
		readkey;
	end;

procedure Menu_Modificar;
	var
		Control:char;
		Clave:integer;
		Pos:integer;
		Val,i,x,y:integer;
	begin
	repeat
	textcolor(white);
	gotoxy(25,5);
	writeln('MENU MODIFICAR: ');
	gotoxy(30,10);
	writeln('1) Museo');
	gotoxy(30,12);
	writeln('2) Obra');
	gotoxy(30,14);
	writeln('3) Volver atrás');
	textcolor(6);
	x:=1;
	y:=2;
	for i:=1 to 21 do //izq
	begin
		gotoxy(x,y);
		writeln('#');
		inc(y);
	end;
	x:=1;
	y:=1;
	for i:=1 to 40 do //arriba
	begin
		gotoxy(x,y);
		writeln('#');
		x:=x+2
	end;
	x:=79;
	y:=2;
	for i:=1 to 21 do //der
	begin
		gotoxy(x,y);
		writeln('#');
		inc(y);
	end;
	x:=1;
	y:=23;
	for i:=1 to 40 do //abajo
	begin
		gotoxy(x,y);
		writeln('#');
		x:=x+2
	end;
	repeat
	textcolor(white);
	until (keypressed = true);
	Control:=readkey;
	case Control of
		'1':begin
			textcolor(white);
			repeat
			clrscr;
			writeln('Ingrese el codigo del museo que desea modificar: ');
				{$I-}
					readln(Clave);
				{$I+}
			Val:=ioresult();
			if Val=0 then
				begin
					Busqueda_Codigo_Museo(Arch_Museo, Nom_Mus, Clave, Pos);
					if Pos>-1 then
						begin
							Modificar_Museo(Arch_Museo, Arch_Director, Nom_Mus, Nom_Dir, Pos);
							Menu_Principal;
						end
					else
						begin
							textbackground(red);
							writeln(#7'El museo no esta registrado. Dar de alta para continuar.');
							textbackground(black);
							readkey;
							Menu_ABMC;
						end;
					end
			else
			begin
				textbackground(red);
				writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
				textbackground(black);
				readkey;
			end;
			until (Pos>-1) and (Val=0);
			end;
			
		'2':begin
			textcolor(white);
			repeat
			clrscr;
			writeln('Ingrese el codigo de la obra que desea modificar: ');
				{$I-}
					readln(Clave);
				{$I+}
				Val:=ioresult();
				if Val=0 then
					begin
						Busqueda_Codigo_Obra(Arch_Obra, Nom_Obr, Clave, Pos);
					if Pos>-1 then
						begin
							Modificar_Obra(Arch_Obra, Arch_Artista, Arch_Museo, Nom_Obr, Nom_Art, Nom_Mus, Pos);
							Menu_Principal;
						end
						else
						begin
							textbackground(red);
							writeln(#7'La obra no esta registrada. Dar de alta para continuar.');
							textbackground(black);
							readkey;
							Menu_ABMC;
						end;
						end
				else
					begin
						textbackground(red);
						writeln(#7'Tecla no válida. Vuelva a intentar.');
						textbackground(black);
						readkey;
					end;
					until (Pos>-1) and (Val=0);
		    end;
		    
		'3':begin
				clrscr;
				Menu_ABMC;
			end;
			else
				clrscr;
				gotoxy(20,10);
				textbackground(red);
				writeln(#7'Tecla no válida. Vuelva a intentar.');
				textbackground(black);
				readkey;
				clrscr;
			end;
		until (Control='1') or (Control='2') or (Control='3');
		readkey;
	end;

procedure Menu_Consultar;
	var
		Control:char;
		i,x,y:integer;
	begin
	clrscr;
	repeat
	textcolor(white);
	gotoxy(25,5);
	writeln('MENU CONSULTAS: ');
	gotoxy(30,10);
	writeln('1) Artista');
	gotoxy(30,12);
	writeln('2) Museo');
	gotoxy(30,14);
	writeln('3) Obra');
	gotoxy(30,16);
	writeln('4) Volver atrás');
	textcolor(6);
	x:=1;
	y:=2;
	for i:=1 to 21 do //izq
	begin
		gotoxy(x,y);
		writeln('#');
		inc(y);
	end;
	x:=1;
	y:=1;
	for i:=1 to 40 do //arriba
	begin
		gotoxy(x,y);
		writeln('#');
		x:=x+2
	end;
	x:=79;
	y:=2;
	for i:=1 to 21 do //der
	begin
		gotoxy(x,y);
		writeln('#');
		inc(y);
	end;
	x:=1;
	y:=23;
	for i:=1 to 40 do //abajo
	begin
		gotoxy(x,y);
		writeln('#');
		x:=x+2
	end;
	repeat
	textcolor(white);
	until keypressed = true;
	Control:=readkey;
	case Control of
		'1':begin
			clrscr;
			Consulta_Artista(Arch_Artista, Arch_Obra, Nom_Art, Nom_Obr);
			Menu_Principal;
			end;
		'2':begin
			clrscr;
			Consulta_Museo(Arch_Director, Arch_Museo, Arch_Obra, Nom_Dir, Nom_Mus, Nom_Obr);
			Menu_Principal;
			end;
		'3':begin
			clrscr;
			Consulta_Obra(Arch_Artista, Arch_Museo, Arch_Obra, Nom_Art, Nom_Mus, Nom_Obr);
			gotoxy(23,12);
			textbackground(6);
			textcolor(black);
			writeln('Presione cualquier tecla para salir.');
			textcolor(white);
			textbackground(black);
			readkey;
			Menu_Principal;
			end;
		'4':Begin
			clrscr;
			Menu_ABMC;
			end;
	else
		clrscr;
		gotoxy(20,10);
		textbackground(red);
		writeln(#7'Tecla no válida. Vuelva a intentar.');
		textbackground(black);
		readkey;
		clrscr;
	end;
	until (Control='1') or (Control='2') or (Control='3') or (Control='4');
	readkey;
	end;

procedure Consulta_Artista(var Arch_Artista:T_Artistas; var Arch_Obra:T_Obras; Nom_Art:string; Nom_Obr:string);
	var
		Reg_Art:R_Artistas;
		DArt,Pos,Val:integer; // Dart: DNI Artista
	begin
	textcolor(white);
	repeat
	gotoxy(1,1);
	writeln('Ingrese el DNI artista que desea consultar: ');
		{$I-}
			gotoxy(45,1);
			readln(Dart);
		{$I+}
		clrscr;
		Val:=ioresult();
		if Val<>0 then
		begin
			textbackground(red);
			gotoxy(1,3);
			writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
			textbackground(black);
		end;
	until Val=0;
	Busqueda_DNI_Artista(Arch_Artista, Nom_Art, Dart, Pos);
		if Pos>-1 then
			begin
				Leer_Artista(Arch_Artista, Nom_Art, Pos, Reg_Art);
				if Reg_Art.Estado_Artista=false then
					begin
						textbackground(red);
						writeln(#7'El artista esta dado de baja. Dar de alta para continuar.');
						textbackground(black);
						readkey;
						Menu_Consultar;
					end;
					Pos:=-1;
					gotoxy(25,4);
					writeln('Artista: ', Reg_Art.ApNom_Artista);
					gotoxy(23,5);
					writeln('--------------------------------------');
					Busqueda_Consulta_Artista(Arch_Obra, Nom_Obr, Reg_Art.DNI_Artista, Pos);
					if Pos=-1 then
						begin
							gotoxy(18,20);
							textbackground(red);
							writeln(#7'No hay ninguna obra registrada con este artista.');
							textbackground(black);
						end;
			end
			else
			begin
				textbackground(red);
				writeln(#7'Este artista no esta registrado. Dar de alta para continuar.');
				textbackground(black);
				readkey;
				Menu_Consultar;
		end;
	end;

procedure Consulta_Museo(var Arch_Director:T_Directores; var Arch_Museo:T_Museos; var Arch_Obra:T_Obras; Nom_Dir:string; Nom_Mus:string; Nom_Obr:string);
	var
		Reg_Dir:R_Directores;
		Reg_Mus:R_Museos;
		Nmus:string;
		Pos:integer;
	begin
	textcolor(white);
	gotoxy(1,1);
	writeln('Ingrese el nombre del museo que desea consultar: ');
	gotoxy(50,1);
	readln(Nmus);
	clrscr;
	Busqueda_Nombre_Museo(Arch_Museo, Nom_Mus, Nmus, Pos);
	if Pos>-1 then
	begin
		Leer_Museo(Arch_Museo, Nom_Mus, Pos, Reg_Mus);
		if Reg_Mus.Estado_Museo = false then
			begin
				textbackground(red);
				gotoxy(1,3);
				writeln(#7'El museo esta dado de baja. Dar de alta para continuar.');
				textbackground(black);
				readkey;
				Menu_Consultar;
			end
		else
			begin
				gotoxy(25,3);
				writeln('Museo: ', Nmus);
				gotoxy(23,4);
				writeln('--------------------------------------');
			end;
			Pos:=-1;
			Busqueda_DNI_Director(Arch_Director, Nom_Dir, Reg_Mus.DNI_Direc, Pos);
			if Pos>-1 then
				begin
					Leer_Director(Arch_Director, Nom_Dir, Pos, Reg_Dir);
					if Reg_Dir.Estado_Dir then
						begin
							gotoxy(25,5);
							writeln('Director: ', Reg_Dir.ApNom_Dir);
							gotoxy(23,6);
							writeln('--------------------------------------');
							Busqueda_Consulta_Museo(Arch_Obra, Nom_Obr, Reg_Mus.Cod_Museo, Pos);
						end
						else
							begin
								textbackground(red);
								writeln(#7'El director esta dado de baja. Dar de alta para continuar.');
								textbackground(black);
							end;
						end
					else
						begin
							textbackground(red);
							writeln(#7'El director del museo no esta registrado. Dar de alta para continuar.');
							textbackground(black);
						end;
						if Pos=-1 then
						begin
							textbackground(red);
							writeln(#7'No hay ninguna obra registrada en este museo.');
							textbackground(black);
						end;
					end
				else
				begin
					textbackground(red);
					writeln(#7'Este museo no esta registrado. Dar de alta para continuar.');
					textbackground(black);
					readkey;
					Menu_Consultar;
				end;
	end;

procedure Consulta_Obra(var Arch_Artista:T_Artistas; var Arch_Museo:T_Museos; var Arch_Obra:T_Obras; Nom_Art:string; Nom_Mus:string; Nom_Obr:string);
	var
		Reg_Art:R_Artistas;
		Reg_Mus:R_Museos;
		Reg_Obr:R_Obras;
		Nobr:string;
		Pos,i,x,y:integer;
	begin
		textcolor(white);
		gotoxy(1,1);
		writeln('Ingrese nombre de la obra que desea consultar: ');
		gotoxy(48,1);
		readln(Nobr);
		Busqueda_Nombre_Obra(Arch_Obra, Nom_Obr, Nobr, Pos);
		if Pos>-1 then
			begin
				clrscr;
				textcolor(6);
				x:=22;
				y:=3;
				for i:=1 to 7 do // izq
					begin
						gotoxy(x,y);
						writeln('|');
						inc(y);
					end;
				x:=23;
				y:=9;
				for i:=1 to 19 do // abajo
					begin
						gotoxy(x,y);
						writeln('_');
						x:=x+2
					end;
				x:=60;
				y:=3;
				for i:=1 to 7 do // der
					begin
						gotoxy(x,y);
						writeln('|');
						inc(y);
					end;
				x:=23;
				y:=2;
				for i:=1 to 19 do // arriba
					begin
						gotoxy(x,y);
						writeln('_');
						x:=x+2
					end;
				textcolor(white);
				Leer_Obra(Arch_Obra, Nom_Obr, Pos, Reg_Obr);
				if Reg_Obr.Estado_Obra  then
					begin
						gotoxy(25,4);
						writeln('Obra: ', Nobr);
						gotoxy(23,5);
						writeln('-------------------------------------');
						Busqueda_DNI_Artista(Arch_Artista, Nom_Art, Reg_Obr.DNI_Artista, Pos);
						if Pos>-1 then
							begin
								Leer_Artista(Arch_Artista, Nom_Art, Pos, Reg_Art);
								if Reg_Art.Estado_Artista then
									begin
										gotoxy(25,6);
										writeln('Artista: ', Reg_Art.ApNom_Artista);
									end
									else
										begin
											textbackground(red);
											gotoxy(25,6);
											writeln(#7'El artista esta dado de baja.');
											textbackground(black);
										end;
							end;
					end
						else
							begin
								textbackground(red);
								writeln(#7'La obra esta dada de baja. Dar de alta para continuar.');
								textbackground(black);
								readkey;
								Menu_Consultar;
							end;
					Busqueda_Codigo_Museo(Arch_Museo, Nom_Mus, Reg_Obr.Cod_Museo, Pos);
					if Pos>-1 then
						begin
							Leer_Museo(Arch_Museo, Nom_Mus, Pos, Reg_Mus);
							if Reg_Mus.Estado_Museo then
							begin
								gotoxy(25,8);
								writeln('Museo: ', Reg_Mus.Nom_Museo);
							end
							else
								begin
									textbackground(red);
									gotoxy(25,8);
									writeln(#7'El museo esta dado de baja.');
									textbackground(black);
									readkey;
									Menu_Consultar;
								end;
						end
						else
							begin
								textbackground(red);
								writeln(#7'El museo donde se encuentra la obra no esta registrado.');
								textbackground(black);
								readkey;
							end;
				end
				else
					begin
						textbackground(red);
						writeln(#7'Esa obra no esta registrada.');
						textbackground(black);
						readkey;
						Menu_Consultar;
					end;
	end;

procedure Menu_Listado;
	var
		Control:char; // teclas
		VA:V_Artistas;
		VD:V_Directores;
		VM:V_Museos;
		VO:V_Obras;
		i,x,y:integer; // grafica
	begin
		Inicializar_Vector_Artista(VA);
		Inicializar_Vector_Director(VD);
		Inicializar_Vector_Museo(VM);
		Inicializar_Vector_Obra(VO);
		clrscr;
	repeat
	textcolor(white);   
	gotoxy(20,5);
	writeln('LISTADOS POR ORDEN: ');
	gotoxy(25,10);
	writeln('1) Artistas ordenados alfabeticamente');
	gotoxy(25,12);
	writeln('2) Directores ordenados alfabeticamente');
	gotoxy(25,14);
	writeln('3) Museos ordenados alfabeticamente');
	gotoxy(25,16);
	writeln('4) Obras ordenadas alfabeticamente');
	gotoxy(25,18);
	writeln('5) Volver al menu principal');
	textcolor(6);
	x:=1;
	y:=2;
	for i:=1 to 21 do //izq
	begin
		gotoxy(x,y);
		writeln('#');
		inc(y);
	end;
	x:=1;
	y:=1;
	for i:=1 to 40 do //arriba
	begin
		gotoxy(x,y);
		writeln('#');
		x:=x+2
	end;
	x:=79;
	y:=2;
	for i:=1 to 21 do //der
	begin
		gotoxy(x,y);
		writeln('#');
		inc(y);
	end;
	x:=1;
	y:=23;
	for i:=1 to 40 do //abajo
	begin
		gotoxy(x,y);
		writeln('#');
		x:=x+2
	end;
	repeat
	textcolor(white);
		until (keypressed = true);
		Control:=readkey;
		case Control of
			'1': begin
					textcolor(white);
					clrscr;
					Listado_Artista(Arch_Artista, Nom_Art, VA);
					Menu_Principal;
				end;
			'2':begin
					textcolor(white);
					clrscr;
					Listado_Director(Arch_Director, Nom_Dir, VD);
					Menu_Principal;
				end;
			'3':begin
					textcolor(white);
					clrscr;
					Listado_Museo(Arch_Museo, Nom_Mus, VM);
					Menu_Principal;
				end;
			'4':begin
					textcolor(white);
					clrscr;
					Listado_Obra(Arch_Obra, Nom_Obr, VO);
					Menu_Principal;
				end;
			'5':begin
					clrscr;
					Menu_Principal;
				end;
		else
			clrscr;
			gotoxy(20,10);
			textbackground(red);
			writeln(#7'Tecla no válida. Vuelva a intentar.');
			textbackground(black);
			readkey;
			clrscr;
		end;
		until (Control='1') or (Control='2') or (Control='3') or (Control='4') or (Control='5');
		readkey;
	end;

procedure Estadisticas(var Arch_Museo:T_Museos; var Arch_Obra:T_Obras; Nom_Mus:string; Nom_Obr:string);
	var
		Reg_Mus:R_Museos;
		Codigo,Pos,Val:integer;
	begin
		textcolor(white);
		writeln('Ingrese el codigo del museo: ');
		{$I-}
			readln(Codigo);
		{$I+}
		Val:=ioresult();
		if Val=0 then
			begin
				Busqueda_Codigo_Museo(Arch_Museo, Nom_Mus, Codigo, Pos);
				if pos>-1 then
					begin
						Leer_Museo(Arch_Museo, Nom_Mus, Pos, Reg_Mus);
						clrscr;
						gotoxy(25,4);
						writeln('Museo: ', Reg_Mus.Nom_Museo);
						gotoxy(21,5);
						writeln('---------------------------------------');
						Estadistica_Museo(Arch_Obra, Nom_Obr, Reg_Mus.Cod_Museo, Pos);
					end
				else
					begin
						clrscr;
						textbackground(red);
						gotoxy(30,8);
						writeln(#7'Este museo no existe.');
						textbackground(black);
					end
				end
		else
		begin
			clrscr;			
			textbackground(red);
			writeln(#7'Debe ingresar solo numeros. Vuelva a intentar.');
			textbackground(black);
		end;
	end;

procedure Menu_Estadistica;
begin
	Estadisticas(Arch_Museo, Arch_Obra, Nom_Mus, Nom_Obr);
	gotoxy(28,18);
	textbackground(6);
	textcolor(black);
	writeln('Presione cualquier tecla.');
	textcolor(white);
	textbackground(black);
	readkey;
	Menu_Principal;
end;

begin
	Nom_Art:='Archivo_Artistas.dat';
	Nom_Dir:='Archivo_Directores.dat';
	Nom_Mus:='Archivo_Museos.dat';
	Nom_Obr:='Archivo_Obras.dat';
end.
