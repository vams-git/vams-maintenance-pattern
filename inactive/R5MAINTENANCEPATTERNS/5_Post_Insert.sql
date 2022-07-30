DECLARE
  mtp R5MAINTENANCEPATTERNS%ROWTYPE;
  err EXCEPTION;
  imsg VARCHAR2(400);

BEGIN
  SELECT * INTO mtp FROM R5MAINTENANCEPATTERNS
  WHERE ROWID = :rowid;
  -- initilise MP as inactive on insert
  IF nvl(mtp.mtp_udfchkbox04,'-') = '-' THEN
    UPDATE R5MAINTENANCEPATTERNS
    SET   mtp_udfchkbox04 = '+'
    WHERE mtp_org = mtp.mtp_org
      AND mtp_code = mtp.mtp_code
      AND mtp_revision = mtp.mtp_revision;
  END IF;

EXCEPTION
  WHEN err THEN
    RAISE_APPLICATION_ERROR (-20003, imsg);
  WHEN OTHERS THEN
    Raise_application_error (-20003,
      'Error in Flex R5MAINTENANCEPATTERNS/Post Insert/5/'
      ||Substr(SQLERRM, 1, 500));
END;