CREATE OR REPLACE PROCEDURE pklingon_v2()
    LANGUAGE PLPGSQL
AS $$
DECLARE
    r VARCHAR := ''; -- Inicializar r a una cadena vacía
    fila RECORD;
    filay RECORD;
BEGIN
    FOR fila IN SELECT * FROM peliculas LOOP
        r := r || E'\n' || 'titulo: ' || fila.titulo;
        SELECT codper INTO filay FROM interpretespel WHERE codpel = fila.codpel;
        IF filay IS NOT NULL THEN
            r := r || E'\n\t' || filay.codper;
        END IF;
    END LOOP;
    RAISE NOTICE '%', r;
END;
$$;

