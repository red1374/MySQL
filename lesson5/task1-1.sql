-- ����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.
UPDATE users SET created_at = NOW(), updated_at = NOW()
    WHERE created_at IS NULL AND updated_at IS NULL  
