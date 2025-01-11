-- Sistema de Control de Presencia
-- Ejercicios
SELECT * FROM Ausentismo_Project..Ausentismo

-- 1. An�lisis de Ausentismo por Raz�n M�dica 
-- Analiza la distribuci�n del tiempo de ausencia en horas seg�n las diferentes categor�as de razones m�dicas (ICD).
-- �Qu� categor�as presentan mayores tiempos de ausencia?

SELECT 
	Reason_for_absence,
	CASE 
		WHEN Reason_for_absence = 0 THEN 'Sin especificar'
		WHEN Reason_for_absence = 1 THEN 'Infecciones y enfermedades parasitarias'
		WHEN Reason_for_absence = 2 THEN 'Neoplasias'
		WHEN Reason_for_absence = 3 THEN 'Enfermedades de la sangre y �rganos formadores de sangre'
		WHEN Reason_for_absence = 4 THEN 'Enfermedades endocrinas, nutricionales y metab�licas'
		WHEN Reason_for_absence = 5 THEN 'Trastornos mentales y del comportamiento'
		WHEN Reason_for_absence = 6 THEN 'Enfermedades del sistema nervioso'
		WHEN Reason_for_absence = 7 THEN 'Enfermedades del ojo y sus anexos'
		WHEN Reason_for_absence = 8 THEN 'Enfermedades del o�do y ap�fisis mastoides'
		WHEN Reason_for_absence = 9 THEN 'Enfermedades del sistema circulatorio'
		WHEN Reason_for_absence = 10 THEN 'Enfermedades del sistema respiratorio'
		WHEN Reason_for_absence = 11 THEN 'Enfermedades del sistema digestivo'
		WHEN Reason_for_absence = 12 THEN 'Enfermedades de la piel y tejido subcut�neo'
		WHEN Reason_for_absence = 13 THEN 'Enfermedades del sistema musculoesquel�tico y tejido conectivo'
		WHEN Reason_for_absence = 14 THEN 'Enfermedades del sistema genitourinario'
		WHEN Reason_for_absence = 15 THEN 'Embarazo, parto y puerperio'
		WHEN Reason_for_absence = 16 THEN 'Ciertas afecciones originadas en el per�odo perinatal'
		WHEN Reason_for_absence = 17 THEN 'Malformaciones cong�nitas, deformidades y anomal�as cromos�micas'
		WHEN Reason_for_absence = 18 THEN 'S�ntomas y hallazgos cl�nicos y de laboratorio no clasificados'
		WHEN Reason_for_absence = 19 THEN 'Lesiones, envenenamientos y otras consecuencias de causas externas'
		WHEN Reason_for_absence = 20 THEN 'Causas externas de morbilidad y mortalidad'
		WHEN Reason_for_absence = 21 THEN 'Factores que influyen en el estado de salud y contacto con servicios'
		WHEN Reason_for_absence = 22 THEN 'Seguimiento de paciente'
		WHEN Reason_for_absence = 23 THEN 'Consulta m�dica'
		WHEN Reason_for_absence = 24 THEN 'Donaci�n de sangre'
		WHEN Reason_for_absence = 25 THEN 'Examen de laboratorio'
		WHEN Reason_for_absence = 26 THEN 'Ausencia injustificada'
		WHEN Reason_for_absence = 27 THEN 'Fisioterapia'
		WHEN Reason_for_absence = 28 THEN 'Consulta dental'
		ELSE 'Raz�n desconocida'
	END AS Razon,
	COUNT(Absenteeism_time_in_hours) AS Horas_Ausentes
FROM 
	Ausentismo_Project..Ausentismo
WHERE
	Absenteeism_time_in_hours IS NOT NULL 
	AND Reason_for_absence IS NOT NULL
GROUP BY
	Reason_for_absence


-- 2. Tasa de Ausentismo por Mes Enunciado: Examina c�mo var�a el tiempo de ausencia en horas a lo largo de los diferentes meses del a�o.
-- �Hay meses con mayor o menor ausentismo?

SELECT 
	CASE 
		WHEN Month_of_absence = 1 THEN 'Enero'
		WHEN Month_of_absence = 2 THEN 'Febrero'
		WHEN Month_of_absence = 3 THEN 'Marzo'
		WHEN Month_of_absence = 4 THEN 'Abril'
		WHEN Month_of_absence = 5 THEN 'Mayo'
		WHEN Month_of_absence = 6 THEN 'Junio'
		WHEN Month_of_absence = 7 THEN 'Julio'
		WHEN Month_of_absence = 8 THEN 'Agosto'
		WHEN Month_of_absence = 9 THEN 'Septiembre'
		WHEN Month_of_absence = 10 THEN 'Octubre'
		WHEN Month_of_absence = 11 THEN 'Noviembre'
		WHEN Month_of_absence = 12 THEN 'Diciembre'
	END AS Mes,
	sum(Absenteeism_time_in_hours) as Horas_Ausentismo
FROM 
	Ausentismo_Project..Ausentismo
WHERE
	Absenteeism_time_in_hours IS NOT NULL
	AND Month_of_absence IS NOT NULL AND Month_of_absence != '0'
GROUP BY
	Month_of_absence
ORDER BY
	Horas_Ausentismo DESC


-- 3. Distribuci�n de Ausencias por D�a de la Semana 
-- Analiza la distribuci�n del tiempo de ausencia en horas seg�n el d�a de la semana. �Algunos d�as presentan mayores tasas de ausentismo que otros?

SELECT 
	CASE 
		WHEN Day_of_the_week = 1 THEN 'Lunes'
		WHEN Day_of_the_week = 2 THEN 'Martes'
		WHEN Day_of_the_week = 3 THEN 'Miercoles'
		WHEN Day_of_the_week = 4 THEN 'Jueves'
		WHEN Day_of_the_week = 5 THEN 'Viernes'
		WHEN Day_of_the_week = 6 THEN 'Sabado'
		WHEN Day_of_the_week = 7 THEN 'Domingo'
	END AS Dia_de_la_semana,
	SUM(Absenteeism_time_in_hours) as Horas_Ausentismo
FROM 
	Ausentismo_Project..Ausentismo
WHERE
	Absenteeism_time_in_hours IS NOT NULL
	AND Day_of_the_week IS NOT NULL AND Day_of_the_week != '0'
GROUP BY
	Day_of_the_week
ORDER BY
	Horas_Ausentismo DESC


-- 4. An�lisis de Ausentismo por Estaci�n del A�o. 
-- Examina c�mo var�a el tiempo de ausencia en horas seg�n la estaci�n del a�o. �Algunas estaciones presentan mayores tasas de ausentismo?

SELECT 
	CASE 
		WHEN Seasons = 1 THEN 'Verano'
		WHEN Seasons = 2 THEN 'Oto�o'
		WHEN Seasons = 3 THEN 'Invierno'
		WHEN Seasons = 4 THEN 'Primera'
	END AS Estacion,
	SUM(Absenteeism_time_in_hours) as Horas_Ausentismo
FROM 
	Ausentismo_Project..Ausentismo
WHERE
	Absenteeism_time_in_hours IS NOT NULL
GROUP BY
	Seasons
ORDER BY
	Horas_Ausentismo DESC


-- 5. Relaci�n entre Gasto en Transporte y Ausentismo. 
-- Analiza si existe una correlaci�n entre el gasto en transporte y el tiempo de ausencia en horas.
-- �Los empleados con mayor gasto en transporte tienden a ausentarse m�s?

SELECT 
	Transportation_expense,
	SUM(Absenteeism_time_in_hours) as Horas_Ausentismo
FROM 
	Ausentismo_Project..Ausentismo
WHERE
	Transportation_expense IS NOT NULL AND
	Absenteeism_time_in_hours IS NOT NULL
GROUP BY
	Transportation_expense
ORDER BY
	Horas_Ausentismo DESC


-- 6. Impacto de la Distancia al Trabajo en el Ausentismo. Examina c�mo la distancia desde la residencia al trabajo influye en el tiempo de ausencia en horas.
-- �Los empleados que viven m�s lejos del trabajo tienen m�s ausentismo?
SELECT 
	Distance_from_Residence_to_Work,
	SUM(Absenteeism_time_in_hours) AS Absenteeism_Time
FROM 
	Ausentismo_Project..Ausentismo
WHERE
	Distance_from_Residence_to_Work IS NOT NULL
	AND Absenteeism_time_in_hours IS NOT NULL
GROUP BY
	Distance_from_Residence_to_Work
ORDER BY
	 Absenteeism_Time DESC



-- 7.An�lisis de Ausentismo por Tiempo de Servicio. 
-- Analiza la relaci�n entre el tiempo de servicio de los empleados y el tiempo de ausencia en horas.
-- �Los empleados con mayor tiempo de servicio tienen menos ausentismo?
SELECT 
	Service_time,
	SUM(Absenteeism_time_in_hours) AS Absenteeism_Time
FROM 
	Ausentismo_Project..Ausentismo
WHERE
	Service_time IS NOT NULL AND
	Absenteeism_time_in_hours IS NOT NULL	
GROUP BY
	Service_time
ORDER BY
	 Service_time DESC


-- 8. Distribuci�n de Ausencias por Edad. Examina c�mo var�a el tiempo de ausencia en horas seg�n la edad de los empleados.
-- �Algunas edades presentan mayores tasas de ausentismo?
SELECT 
	Age,
	SUM(Absenteeism_time_in_hours) AS Absenteeism_Time
FROM 
	Ausentismo_Project..Ausentismo
WHERE
	Age IS NOT NULL AND
	Absenteeism_time_in_hours IS NOT NULL	
GROUP BY
	Age
ORDER BY
	Age DESC


-- 9. Relaci�n entre Carga de Trabajo y Ausentismo. Analiza si existe una correlaci�n entre la carga de trabajo promedio diaria y el tiempo de ausencia en horas.
-- �Los empleados con mayor carga de trabajo tienden a ausentarse m�s?
SELECT 
	[Work_load_AverageDay ],
	SUM(Absenteeism_time_in_hours) AS Absenteeism_Time
FROM 
	Ausentismo_Project..Ausentismo
WHERE
	[Work_load_AverageDay ] IS NOT NULL AND
	Absenteeism_time_in_hours IS NOT NULL	
GROUP BY
	[Work_load_AverageDay ]
ORDER BY
	 [Work_load_AverageDay ] DESC




-- 10. An�lisis de Ausentismo por Incumplimiento Disciplinario. Examina c�mo el incumplimiento disciplinario afecta el tiempo de ausencia en horas.
-- �Los empleados con incumplimiento disciplinario tienen m�s ausentismo?
SELECT 
	Disciplinary_failure,
	SUM(Absenteeism_time_in_hours) AS Absenteeism_Time
FROM Ausentismo_Project..Ausentismo
WHERE
	Disciplinary_failure IS NOT NULL AND
	Absenteeism_time_in_hours IS NOT NULL
GROUP BY
	Disciplinary_failure
ORDER BY
	 Disciplinary_failure DESC


-- 11. Impacto de la Educaci�n en el Ausentismo. Analiza c�mo el nivel educativo de los empleados influye en el tiempo de ausencia en horas.
-- �Los empleados con mayor nivel educativo tienen menos ausentismo?
SELECT 
	Education,
	SUM(Absenteeism_time_in_hours) AS Absenteeism_Time
FROM Ausentismo_Project..Ausentismo
WHERE
	Education IS NOT NULL AND
	Absenteeism_time_in_hours IS NOT NULL
GROUP BY
	Education
ORDER BY
	 Education ASC


-- 12. Relaci�n entre N�mero de Hijos y Ausentismo. Examina si existe una correlaci�n entre el n�mero de hijos y el tiempo de ausencia en horas.
-- �Los empleados con m�s hijos tienden a ausentarse m�s? 
SELECT 
	Son,
	SUM(Absenteeism_time_in_hours) AS Absenteeism_Time
FROM Ausentismo_Project..Ausentismo
WHERE
	Son IS NOT NULL AND
	Absenteeism_time_in_hours IS NOT NULL
GROUP BY
	Son
ORDER BY
	 Son ASC


-- 13. An�lisis de Ausentismo por Consumo Social de Alcohol Enunciado: Analiza c�mo el consumo social de alcohol afecta el tiempo de ausencia en horas. 
-- �Los empleados que consumen alcohol socialmente tienen m�s ausentismo?
SELECT 
	Social_drinker,
	SUM(Absenteeism_time_in_hours) AS Absenteeism_Time
FROM Ausentismo_Project..Ausentismo
WHERE
	Social_drinker IS NOT NULL AND
	Absenteeism_time_in_hours IS NOT NULL
GROUP BY
	Social_drinker
ORDER BY
	 Social_drinker ASC



-- 14. Impacto del Consumo Social de Tabaco en el Ausentismo. Examina c�mo el consumo social de tabaco influye en el tiempo de ausencia en horas. 
-- �Los empleados que consumen tabaco socialmente tienen m�s ausentismo?
SELECT 
	Social_smoker,
	SUM(Absenteeism_time_in_hours) AS Absenteeism_Time
FROM Ausentismo_Project..Ausentismo
WHERE
	Social_smoker IS NOT NULL AND
	Absenteeism_time_in_hours IS NOT NULL
GROUP BY
	Social_smoker
ORDER BY
	 Social_smoker ASC



-- 15. Relaci�n entre N�mero de Mascotas y Ausentismo. Analiza si existe una correlaci�n entre el n�mero de mascotas y el tiempo de ausencia en horas.
-- �Los empleados con m�s mascotas tienden a ausentarse m�s?
SELECT 
	Pet,
	SUM(Absenteeism_time_in_hours) AS Absenteeism_Time
FROM Ausentismo_Project..Ausentismo
WHERE
	Pet IS NOT NULL AND
	Absenteeism_time_in_hours IS NOT NULL
GROUP BY
	Pet
ORDER BY
	 Pet ASC


-- 16. An�lisis de Ausentismo por �ndice de Masa Corporal (IMC). Analiza la relaci�n entre el �ndice de masa corporal (IMC) de los empleados y el tiempo de ausencia en horas.
-- �Los empleados con un IMC m�s alto tienen m�s ausentismo?
WITH IMC_Categorias AS (
	SELECT 
		CASE 
			WHEN Body_mass_index < 20 THEN 'Bajo Peso'
			WHEN Body_mass_index >= 20 AND Body_mass_index <= 30 THEN 'Normal'
			WHEN Body_mass_index > 30 AND Body_mass_index <= 35 THEN 'Sobrepeso'
			WHEN Body_mass_index > 35 THEN 'Obesidad'
		END AS PesoCorporal,
		Absenteeism_time_in_hours
	FROM 
		Ausentismo_Project..Ausentismo
	WHERE
		Body_mass_index IS NOT NULL AND
		Absenteeism_time_in_hours IS NOT NULL
)
SELECT 
	PesoCorporal,
	SUM(Absenteeism_time_in_hours) AS Horas_Ausentismo
FROM 
	IMC_Categorias
GROUP BY 
	PesoCorporal
ORDER BY 
	Horas_Ausentismo DESC;


-- 17. An�lisis de Ausentismo por Tiempo de Servicio y Edad. Examina c�mo la combinaci�n de tiempo de servicio y edad afecta el tiempo de ausencia en horas. 
-- �Existen patrones espec�ficos de ausentismo entre diferentes grupos de edad y antig�edad laboral?
SELECT 
	Service_time,
	Age,
	SUM(Absenteeism_time_in_hours) AS Horas_Ausentismo
FROM 
	Ausentismo_Project..Ausentismo
WHERE
	Service_time IS NOT NULL AND
	AGE IS NOT NULL AND
	Absenteeism_time_in_hours IS NOT NULL
GROUP BY
	Service_time,
	Age
ORDER BY
	AGE DESC


-- 18. Promedio de Ausentismo por Nivel Educativo. Calcula el promedio de tiempo de ausencia en horas para cada nivel educativo de los empleados.
-- �Qu� nivel educativo tiene el mayor tiempo promedio de ausencia?
WITH Educacion_Categorias AS (
	SELECT 
		CASE 
			WHEN Education = 1 THEN 'Secundaria'
			WHEN Education = 2 THEN 'Universidad'
			WHEN Education = 3 THEN 'Postgrado'
			WHEN Education = 4 THEN 'Maestr�a/Doctorado'
		END AS Educacion,
		Absenteeism_time_in_hours
	FROM 
		Ausentismo_Project..Ausentismo
	WHERE
		Education IS NOT NULL AND
		Absenteeism_time_in_hours IS NOT NULL
)
SELECT 
	Educacion,
	ROUND(AVG(Absenteeism_time_in_hours),2) AS Horas_Ausentismo
FROM 
	Educacion_Categorias
GROUP BY 
	Educacion
ORDER BY 
	Horas_Ausentismo DESC;

-- 19. Predicci�n de Ausentismo Basado en Factores Demogr�ficos. Utilizando los datos disponibles, realiza una consulta que intente predecir el ausentismo en funci�n de variables como edad, n�mero de hijos, nivel educativo, y otros factores demogr�ficos.
-- �Qu� variables son m�s predictivas del ausentismo?
SELECT 
    Age AS Edad,
    Education AS Nivel_Educativo,
    Son AS Numero_Hijos,
    Social_drinker AS Bebedor_Social,
    Social_smoker AS Fumador_Social,
    Pet AS Numero_Mascotas,
    AVG(Absenteeism_time_in_hours) AS Promedio_Horas_Ausentismo,
    COUNT(*) AS Total_Registros
FROM 
    Ausentismo_Project..Ausentismo
WHERE
	Age is not null AND Education is not null and
	son is not null AND Social_drinker is not null and
	Social_smoker is not null AND pet is not null AND
    Absenteeism_time_in_hours IS NOT NULL
GROUP BY 
    Age,
    Education,
    Son,
    Social_drinker,
    Social_smoker,
    Pet
ORDER BY 
    Promedio_Horas_Ausentismo DESC


-- 20. Comparaci�n de Ausentismo entre Empleados con Diferentes Comportamientos de Salud. 
-- Analiza si existe una diferencia significativa en el tiempo de ausencia en horas entre los empleados que consumen alcohol o tabaco socialmente, en comparaci�n con los que no lo hacen. 
--�El comportamiento de salud tiene impacto en el ausentismo?
SELECT
    CASE 
        WHEN Social_drinker = 1 AND Social_smoker = 1 THEN 'Bebedor y Fumador Social'
        WHEN Social_drinker = 1 AND Social_smoker = 0 THEN 'Solo Bebedor Social'
        WHEN Social_drinker = 0 AND Social_smoker = 1 THEN 'Solo Fumador Social'
        ELSE 'No Bebedor ni Fumador Social'
    END AS Comportamiento_Salud,
    AVG(Absenteeism_time_in_hours) AS Promedio_Horas_Ausentismo,
    SUM(Absenteeism_time_in_hours) AS Total_Horas_Ausentismo,
    COUNT(*) AS Total_Empleados
FROM 
    Ausentismo_Project..Ausentismo
WHERE 
	Social_drinker is not null AND
	Social_smoker is not null AND
    Absenteeism_time_in_hours IS NOT NULL
GROUP BY 
    Social_drinker, 
    Social_smoker
ORDER BY 
    Promedio_Horas_Ausentismo DESC;
