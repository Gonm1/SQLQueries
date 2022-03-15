-- Mostrar el nombre y apellidos de los alumnos, la carrera y facultad a la que pertenecen. Ordenados por Nombre del alumno
SELECT A.ALU_NOMBRES, A.ALU_PATERNO, A.ALU_MATERNO, C.CAR_NOMBRE, F.FAC_NOMBRE
FROM ALUMNO A
JOIN CARRERA C ON A.CAR_CODIGO = C.CAR_CODIGO
JOIN FACULTAD F ON C.FAC_CORREL = F.FAC_CORREL
ORDER BY ALU_NOMBRES

-- Listar el código y nombre de las Asignaturas que dictaron los profesores no vigentes en el semestre 2 del año 2011, ordenados por nombre de la asignatura.
SELECT A.ASI_CODIGO, A.ASI_NOMBRE
FROM ASIGNATURA A
JOIN DICTA D ON A.ASI_CODIGO = D.ASI_CODIGO
JOIN PROFESOR P ON D.PRO_RUT = P.PRO_RUT
WHERE P.PRO_VIGENTE = 'N'
AND D.DIC_ANO = 2011
AND D.DIC_SEMESTRE = 2
ORDER BY A.ASI_NOMBRE

-- Mostrar a los alumnos que no han inscrito ninguna asignatura.
SELECT A.ALU_RUT, A.ALU_NOMBRES, A.ALU_PATERNO, A.ALU_MATERNO
FROM ALUMNO A
LEFT JOIN INSCRIBE I ON A.ALU_RUT = I.ALU_RUT
WHERE I.ALU_RUT IS NULL

-- Mostrar sólo las comunas de las que provienen los alumnos de la universidad.
SELECT DISTINCT C.COM_NOMBRE
FROM COMUNA C
JOIN ALUMNO A ON C.COM_CORREL = A.COM_CORREL

-- Mostrar sólo las comunas de las que no proviene ningún alumno de la universidad.
SELECT COMUNA.COM_NOMBRE
FROM COMUNA
LEFT JOIN ALUMNO ON ALUMNO.COM_CORREL = COMUNA.COM_CORREL
WHERE ALUMNO.COM_CORREL IS NULL

-- Mostrar el código y nombre de todas las asignaturas, con el nombre del profesor que la dicta, el semestre y año en que se imparte, ordenadas por año y semestre.
SELECT A.ASI_CODIGO, A.ASI_NOMBRE, P.PRO_NOMBRES, D.DIC_SEMESTRE, D.DIC_ANO
FROM DICTA D
JOIN ASIGNATURA A ON D.ASI_CODIGO = A.ASI_CODIGO
JOIN PROFESOR P ON D.PRO_RUT = P.PRO_RUT
ORDER BY D.DIC_SEMESTRE, D.DIC_ANO

-- Profesores que no han dictado una asignatura el semestre 2 del año 2010.
SELECT P.PRO_NOMBRES
FROM PROFESOR P
WHERE NOT EXISTS (
	SELECT *
	FROM DICTA D
	WHERE P.PRO_RUT = D.PRO_RUT
	AND D.DIC_ANO = 2010
	AND D.DIC_SEMESTRE = 2)

-- Mostrar el listado de las asignaturas con el nombre del departamento y facultad a ala que pertencen y que tienen más de 3 créditos. Ordenar en orden alfabetico por nombre de la asignatura.
SELECT A.ASI_NOMBRE, D.DEP_NOMBRE, F.FAC_NOMBRE
FROM ASIGNATURA A
JOIN DEPARTAMENTO D ON A.DEP_CORREL = D.DEP_CORREL
JOIN FACULTAD F ON D.FAC_CORREL = F.FAC_CORREL
WHERE A.ASI_CREDITOS > 3
ORDER BY A.ASI_NOMBRE ASC

-- Mostrar las carreras que no tienen alumnos matriculados.
SELECT C.CAR_NOMBRE
FROM CARRERA C
LEFT JOIN ALUMNO A ON C.CAR_CODIGO = A.CAR_CODIGO
WHERE A.CAR_CODIGO IS NULL

-- Mostrar el RUT, nombre de los alumnos y suma total de créditos inscritos en el semestre 1 del año 2010.
SELECT A.ALU_RUT, A.ALU_NOMBRES, A.ALU_PATERNO, A.ALU_MATERNO, SUM(R.ASI_CREDITOS) AS CREDITOS_TOTALES
FROM ALUMNO A
JOIN INSCRIBE I ON A.ALU_RUT = I.ALU_RUT
JOIN ASIGNATURA R ON I.ASI_CODIGO = R.ASI_CODIGO
WHERE I.INS_SEMESTRE = 1
AND I.INS_ANO = 2010
GROUP BY A.ALU_RUT, A.ALU_NOMBRES, A.ALU_PATERNO, A.ALU_MATERNO