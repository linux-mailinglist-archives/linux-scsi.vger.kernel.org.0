Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF7076FEAB
	for <lists+linux-scsi@lfdr.de>; Fri,  4 Aug 2023 12:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjHDKn7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Aug 2023 06:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjHDKnz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 4 Aug 2023 06:43:55 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AD446B3
        for <linux-scsi@vger.kernel.org>; Fri,  4 Aug 2023 03:43:55 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686b9920362so1400130b3a.1
        for <linux-scsi@vger.kernel.org>; Fri, 04 Aug 2023 03:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1691145834; x=1691750634;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ROBA6AZ8vVg3GtqSjeeBcbJ9hpZYbHGqDYAZLYcFruo=;
        b=gGsmGHcHIfTEvYF5tfESlfsGyY3ovH/k2IG+iPA8JnWdm8uRJmrwDO9KJ0caui8iE6
         Ssf5hPXzUP3b5baBjWeBoN/aVe05Q/Eqbq9tKsrBZBBIAvZ5IH7cQINHQqEP6gKrqn1Q
         DvYqDL0anXrGwgCg8Y1O0bCzKc2WGEguECgrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691145834; x=1691750634;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ROBA6AZ8vVg3GtqSjeeBcbJ9hpZYbHGqDYAZLYcFruo=;
        b=ltMdxe625MCgIrsX6mErrWK2Y8cuf8k1vykj/hmrXurg8AVtSSPSgLXX0pSiLY+09Q
         hB7xbaL43jQgOeP4s7LdD8sZOBdfskjLSdZI2RyCrMwZWxf7JFFH0xCIs18QefW0bnZ8
         SH1+ywyJ4uesLEY5TpvHOKUXdb92O0yvFzi28hfl+Iq1p4XRoLvG/wQ+SijUI6wWKNk1
         FZnM90pDRBlPJqCDOjWGqbZ2Y+USUBZGZSFZkuebIN2s5z61qxHnx95e5V9RPJUfJrXc
         o5Br1e/7X1PkFLyz5ssdaubzIiURyAQFDsIvkX93UW3H3nmvYIosYAfCgBkNRVV3hdd+
         EXVQ==
X-Gm-Message-State: AOJu0Yxolu8uHrTxhMjodlHMKvJn0JKRiLAoROiWSGt32Zi4WZHZ0egD
        fOa3sUactnQknnJ8ar2hnrQ1rNvA75gQ1I38OZagirbXCF9+yw4sgPPyGmEzF9VKE+oy1HxYXfy
        0Y6DhORAcxVpFP0a9EMWLVUf2LcIzslxd945tMoYz0KgowdELddl2Ws02htCN/Du6A0TvXSt3N7
        qOojctyKarWQ==
X-Google-Smtp-Source: AGHT+IHFJwkMlvQAIQsegbUk3pAT/o18qfFzC2EHo0oQVeVxeRCysGlWdNglG2Kdt+bojZXNBh95YA==
X-Received: by 2002:a05:6a20:320a:b0:134:409f:41f4 with SMTP id hl10-20020a056a20320a00b00134409f41f4mr1130948pzc.24.1691145834016;
        Fri, 04 Aug 2023 03:43:54 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jb15-20020a170903258f00b001bb988ac243sm1424463plb.297.2023.08.04.03.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 03:43:53 -0700 (PDT)
From:   Ranjan Kumar <ranjan.kumar@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     rajsekhar.chundru@broadcom.com, sathya.prakash@broadcom.com,
        sumit.saxena@broadcom.com, chandrakanth.patil@broadcom.com,
        Ranjan Kumar <ranjan.kumar@broadcom.com>
Subject: [PATCH v3 2/6] mpi3mr: Update MPI Headers to version 3.00.28
Date:   Fri,  4 Aug 2023 16:12:44 +0530
Message-Id: <20230804104248.118924-3-ranjan.kumar@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230804104248.118924-1-ranjan.kumar@broadcom.com>
References: <20230804104248.118924-1-ranjan.kumar@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ba5a050602169210"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--000000000000ba5a050602169210
Content-Transfer-Encoding: 8bit

Updated MPI Headers to version 3.00.28

Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
---
 drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h      | 2 +-
 drivers/scsi/mpi3mr/mpi/mpi30_ioc.h       | 1 +
 drivers/scsi/mpi3mr/mpi/mpi30_transport.h | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h b/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h
index 2fc196499c89..35f81af40f51 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h
@@ -1482,7 +1482,7 @@ struct mpi3_security_page0 {
 #define MPI3_SECURITY1_KEY_RECORD_MAX      1
 #endif
 #ifndef MPI3_SECURITY1_PAD_MAX
-#define MPI3_SECURITY1_PAD_MAX      1
+#define MPI3_SECURITY1_PAD_MAX      4
 #endif
 union mpi3_security1_key_data {
 	__le32                             dword[128];
diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h b/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h
index f5e9c2309ce6..1e4a60fc655f 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h
@@ -600,6 +600,7 @@ struct mpi3_event_data_pcie_error_threshold {
 	__le16                                 threshold_count;
 	__le16                                 attached_dev_handle;
 	__le16                                 reserved12;
+	__le32                                 reserved14;
 };
 
 #define MPI3_EVENT_PCI_ERROR_RC_THRESHOLD_EXCEEDED          (0x00)
diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_transport.h b/drivers/scsi/mpi3mr/mpi/mpi30_transport.h
index 441cfc2c7f09..1e0a3dcaf723 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_transport.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_transport.h
@@ -18,7 +18,7 @@ union mpi3_version_union {
 
 #define MPI3_VERSION_MAJOR                                              (3)
 #define MPI3_VERSION_MINOR                                              (0)
-#define MPI3_VERSION_UNIT                                               (27)
+#define MPI3_VERSION_UNIT                                               (28)
 #define MPI3_VERSION_DEV                                                (0)
 #define MPI3_DEVHANDLE_INVALID                                          (0xffff)
 struct mpi3_sysif_oper_queue_indexes {
-- 
2.31.1


--000000000000ba5a050602169210
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
GK2Ee6ez7fr/FL1RWbOPVHJR+deNIorOjW7U5HVwnRYhM1OR4mAkrkqcN+3kwae0KmVO3SDKFd7h
Ok4L2e1ixyaRTo379Ur3iVTnagglDOliayMGRITBPe0CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcmFuamFuLmt1bWFyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU8WuEiYXvpeCaubgLCCFoyRBc
8QwwDQYJKoZIhvcNAQELBQADggEBAA5th3yz1fvJCBmK21x68IdDNFC0gmynT76I3fOgslLHc7ey
lC9VXLb+vJ863blS/WxEOwf0fvc0ks7qYWl8xisInHu5AX9glaooGhLImlzE0l9rDf0tcq2kkgc4
CXL9UGDEoqdxfRj3j9xn9fm9gpTBWSck6ufc/8RV1TLVjcZvrYkMqQwoVulGkr+HCnzaEFxBRmO/
nWsVitGa1sKS9usFXoW1bQXgJ9TtRdy8gka8b9SaKnh4TaiEKpdl8ztXhugWp7RpFGVu/ZZ8narx
0H1L9W/UIr3J/uYokdFr+hIrXOfOwJLB18bWOTCVWxTEo4zYC8qZ/h7UcS5aispm/rkxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxMV+PqteWF5WGw7jsw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKTwYzUcwc++yQ2LgI74FyHS/OiacJeN
sNsvfbf/JhstMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgw
NDEwNDM1NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAIVE30Q/jGwvM57nMRsyj5uZZvweQu4k/L99ENY/071su5PaSB
JvdxHZuTJD04DMcV9HY6exbyu/hfeFirQP+6cuqNO/OQoH3ANoJBuFA82YW89ghA0J6BrCBCyFMT
m4Ip2ijCqN1Jii3F5XB31Rkgwu7U2McTQLPji2xJq9tGqHOUNbP90cQSvEihnzG02g8aoVqNJCrt
RNZZmERzC1q2TkFAHl+v89Oh31SMrsl3szbSWD06W4yttgLe8obaERYUNbT4epSfQvk0UjnaZxnD
/6Sl3f3ypY1m6aAJKp+4loCpNKi36x3xR77xSF5EMa4sTdvSnUxXaBBCNbqtnbew
--000000000000ba5a050602169210--
