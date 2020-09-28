Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010FF27AD12
	for <lists+linux-scsi@lfdr.de>; Mon, 28 Sep 2020 13:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgI1Lor (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 28 Sep 2020 07:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgI1Lor (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 28 Sep 2020 07:44:47 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEE7C061755
        for <linux-scsi@vger.kernel.org>; Mon, 28 Sep 2020 04:44:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mn7so485355pjb.5
        for <linux-scsi@vger.kernel.org>; Mon, 28 Sep 2020 04:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Oa7nLWj6s51DZc57OiVZhXUIx9niedcnvuQsf9d3Ls=;
        b=c7ODsJcAHVAEREasZy/RYGm8CW1kWtXRke8DWnxLf7FU8qm5rrEtWpPoAJ44qTNWl7
         c2ZxaBTb/MaTWCRrMtc2J1Dw5XItD/CrOsRZ5N5IWeOeqHQnfmo1AsKDb54O1WEFjP/H
         qm/rmTkJO9hHmE0ul2mfXBOBrjaC4OrA1mxpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Oa7nLWj6s51DZc57OiVZhXUIx9niedcnvuQsf9d3Ls=;
        b=gAEyNAKPOoBDOMaNY1CfccKTgepveSAofiEj/spdB/cvTXifM1h6z3SyJ7yfBzvNCT
         nxfunrb5b0VOu7AFoJyNpNcz0WwJ2nGKtZ/atBbyNgUaSG9uwBU6tlWqXWLDiQSSPyx8
         2FyXIk+ZyzfVC3ExjBkkjTKnRkxSThCOhupwK46Josc0Xfvou3zw/O4sgmAVNTKueNtD
         uz0CoXgSmnCrw43MDAyhWzPnOS050DNBbOO/ixOdtTvPyLJZIWL3d8s9JXPv3smYXd34
         UGBv59j2woO7heTpLZ7txWFKOkqHK0gx/KaIhd5iWvBMZTpeBHKDfImg+QtbgJUVGqfG
         Hl6g==
X-Gm-Message-State: AOAM5313kQtpeTCW6qGnG9jgC1jhDLLynA2malqqmrmjDn2xzWu80kab
        mHQ6Tj4s8SxAr4t6+FmxCMHNZ6WN4cFG83FP+CBMjF6OxdCa65EgEnylLuFE0P24aTWOfm5Z+R1
        x5wLCLOJDVyMfs9g1Txp3q/mzkA5TXGA4KgiKNSCPewwWd3aBOzsFMjbNTGxGmz9OSdIohfWsx+
        xIEsqsCDan
X-Google-Smtp-Source: ABdhPJxwV7uCS5YVJpDdkLZbENfht5AUw2vUe4TtRrf+DUBiss0QPpT+a8z9sPFn1lLJCMKMdZqsQA==
X-Received: by 2002:a17:90b:d86:: with SMTP id bg6mr937203pjb.155.1601293486055;
        Mon, 28 Sep 2020 04:44:46 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w19sm1468866pfq.60.2020.09.28.04.44.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 04:44:45 -0700 (PDT)
From:   Muneendra <muneendra.kumar@broadcom.com>
To:     linux-scsi@vger.kernel.org, hare@suse.de
Cc:     jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
        Muneendra <muneendra.kumar@broadcom.com>
Subject: [PATCH v2 6/8] scsi_transport_fc: Added a new rport state FC_PORTSTATE_MARGINAL
Date:   Mon, 28 Sep 2020 10:20:55 +0530
Message-Id: <1601268657-940-7-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1601268657-940-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1601268657-940-1-git-send-email-muneendra.kumar@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000071350e05b05e31a8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--00000000000071350e05b05e31a8

Added a new rport state FC_PORTSTATE_MARGINAL.

Made changes in fc_remote_port_chkready function to treat marginal and
online as same

Added a new inline function fc_rport_chkmarginal_set_noretries
which will set the SCMD_NORETRIES_ABORT bit in cmd->state if rport state
is marginal.

Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>

---
v2:
New patch
---
 include/scsi/scsi_transport_fc.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/scsi/scsi_transport_fc.h b/include/scsi/scsi_transport_fc.h
index 1c7dd35cb7a0..ee99c6ca7e45 100644
--- a/include/scsi/scsi_transport_fc.h
+++ b/include/scsi/scsi_transport_fc.h
@@ -14,6 +14,7 @@
 #include <linux/bsg-lib.h>
 #include <asm/unaligned.h>
 #include <scsi/scsi.h>
+#include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_netlink.h>
 #include <scsi/scsi_host.h>
 
@@ -67,6 +68,7 @@ enum fc_port_state {
 	FC_PORTSTATE_ERROR,
 	FC_PORTSTATE_LOOPBACK,
 	FC_PORTSTATE_DELETED,
+	FC_PORTSTATE_MARGINAL,
 };
 
 
@@ -383,6 +385,7 @@ struct fc_starget_attrs {	/* aka fc_target_attrs */
 	u64 node_name;
 	u64 port_name;
 	u32 port_id;
+	enum fc_port_state port_state;
 };
 
 #define fc_starget_node_name(x) \
@@ -391,6 +394,8 @@ struct fc_starget_attrs {	/* aka fc_target_attrs */
 	(((struct fc_starget_attrs *)&(x)->starget_data)->port_name)
 #define fc_starget_port_id(x) \
 	(((struct fc_starget_attrs *)&(x)->starget_data)->port_id)
+#define fc_starget_port_state(x) \
+	(((struct fc_starget_attrs *)&(x)->starget_data)->port_state)
 
 #define starget_to_rport(s)			\
 	scsi_is_fc_rport(s->dev.parent) ? dev_to_rport(s->dev.parent) : NULL
@@ -723,6 +728,7 @@ fc_remote_port_chkready(struct fc_rport *rport)
 
 	switch (rport->port_state) {
 	case FC_PORTSTATE_ONLINE:
+	case FC_PORTSTATE_MARGINAL:
 		if (rport->roles & FC_PORT_ROLE_FCP_TARGET)
 			result = 0;
 		else if (rport->flags & FC_RPORT_DEVLOSS_PENDING)
@@ -743,6 +749,24 @@ fc_remote_port_chkready(struct fc_rport *rport)
 	return result;
 }
 
+/**
+ * fc_rport_chkmarginal_set_noretries - Set the SCMD_NORETRIES_ABORT bit
+ * in cmd->state if port state is marginal prior to initiating
+ * io to the port.
+ * @rport:	remote port to be checked
+ * @scmd:	scsi_cmd
+ **/
+static inline void
+fc_rport_chkmarginal_set_noretries(struct fc_rport *rport, struct scsi_cmnd *cmd)
+{
+	if ((rport->port_state == FC_PORTSTATE_MARGINAL) &&
+		 (cmd->request->cmd_flags & REQ_FAILFAST_TRANSPORT))
+		set_bit(SCMD_NORETRIES_ABORT, &cmd->state);
+	else
+		clear_bit(SCMD_NORETRIES_ABORT, &cmd->state);
+
+}
+
 static inline u64 wwn_to_u64(const u8 *wwn)
 {
 	return get_unaligned_be64(wwn);
-- 
2.26.2


--00000000000071350e05b05e31a8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
J/4V6ms/nIUi+/4vPYjckYUbRzkXm1/X0IyUfpp5cgdrFn9jBIk69fQGAUEhnVvwcXnHWotYxZFd
Xew5Fz0CAwEAAaOCAdMwggHPMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYI
KwYBBQUHMAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxz
aWduMnNoYTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5j
b20vZ3NwZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsG
AQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAA
MEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNp
Z24yc2hhMmczLmNybDAnBgNVHREEIDAegRxtdW5lZW5kcmEua3VtYXJAYnJvYWRjb20uY29tMBMG
A1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFGlygmIxZ5VEhXeRgMQENkmdewthMB0GA1Ud
DgQWBBR6On9cEmlB2VsuST951zNMSKtFBzANBgkqhkiG9w0BAQsFAAOCAQEAOGDBLQ17Ge8BVULh
hsKhgh5eDx0mNmRRdhvTJnxOTRX5QsOKvsJGOUbyrKjD3BTTcGmIUti9HmbqDe/3gRTbhu8LA508
LbMkW5lUoTb8ycBNOKLYhNE8UEOY8jRTUtMEhzT6NJDEE+1hb3kSGfArrrF3Z8pRYiUUhcpC5GKL
9KsxA+DECRfSGfXJJQSq6nEZUGKhz+dz5CV1s8UIZLe9HEEfyJO4eRP+Fw9X16cthAbY0kpVnAvT
/j45FAauY/h87uphdvSb5wC9v5w4VO0JKs0yNUjyWXg/RG+6JCvcViLFLAlRCLrcRcVaQwWZQ3YB
EpmWnHflnrBcah5Ozy137DGCAm8wggJrAgEBMG0wXTELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEds
b2JhbFNpZ24gbnYtc2ExMzAxBgNVBAMTKkdsb2JhbFNpZ24gUGVyc29uYWxTaWduIDIgQ0EgLSBT
SEEyNTYgLSBHMwIMX/krgFDQUQNyOf+1MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEi
BCAH+Hz8OtTmqUwe61CJRUqb1yeiAV62L0zZLfe1u/jGGzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yMDA5MjgxMTQ0NDZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEK
MAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAO+1d9Ls8vCyiLuKs
QlBd5bTA91QzHOsYfRpJLdjmQ0Iz+Us+nnNTaANPYeT1lfzSKhQXA80TMOIJo51UnqcdKSJO66ZI
EkFrr+mMJqFwKpJY7sSXNRx5ckrOjvHDux5gTSR7Dbue0lj3qoKcw7mdpV72rRBE4JqUBWEtfnme
tnjsRLKCsauErvUunKXr6PPkUxW+U9WpnzDSvOmzj/j7bh8cfXm71Lx91LvFkvO7DBLFm28FlbwX
gECSyePcorAEzpYBT5Du+omiRgYfu6vljWOpXeeeNvQ8wiq3a0KlB/LFHKArzxTKNx9vykbw286F
gXGVfP8eO8j0wzpw1nTOEA==
--00000000000071350e05b05e31a8--
