hydro = struct();

hydro = Read_WAMIT(hydro,'cyl.out',[]);
hydro = Radiation_IRF(hydro,5,[],[],[],[]);
hydro = Radiation_IRF_SS(hydro,[],[]);
hydro = Excitation_IRF(hydro,5,[],[],[],[]);
Write_H5(hydro)
Plot_BEMIO(hydro)