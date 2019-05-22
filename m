Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F7225B51
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfEVAtg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:36 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46509 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbfEVAtg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:36 -0400
Received: by mail-pl1-f196.google.com with SMTP id r18so159624pls.13
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UPAcGN2LwzH3hCrG35HVFdEySeJoW3EL3RwTklAowHc=;
        b=f1+f/5RIpao1RWNcTw5enm8saYFulr9cL1POgRzpgiaxs0UeIoAGB+8HJWY2mUx1gv
         MEfXlY148aoEGeb+lJst4fNigNZjouGtdM4DLZvOanfZaL2i0YUFvNn4j4kfHVR20118
         DdJChRtKstgI0oyLC/e74CFr+JBSTdrS49KkkidjW1/I1QJJum0l7KpKoy9VFhFszSE5
         KlHUjp7R7Og6zb0DoW00UERj2kdL1+MQl6BrjTk4Mw5d1oIoxgF0jnv3vl3MlpfUwJwU
         k0aHrYK+zvog0HzsWQjotURDFtMjQgt3wtmb3H2i928ped4S9pyyC6HMoVZECRPFydxG
         t8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UPAcGN2LwzH3hCrG35HVFdEySeJoW3EL3RwTklAowHc=;
        b=UpKAIty8G+wKzOD0gdpsZxTeNINxt+P66iD1H/0awgEmp8IMKv0i2Kaa40UUSbgK2u
         atR1qJso2+DZerNds4xq1LCeFpUjCb1h4bpuhUHHp7CSTGej91HEQ7KSI8/jHrvJaqdY
         PToCi4lrvsakhW1SvR3WPSfABiPYHTUeUFUnTfwFs3zFEsUCmQFFo3cHEES9ZDSQbD6G
         sRXGQp0a4wU/Hedrb10Uvpxh3NGlnZWzTuR24NxFW/bWL9HS2O//tPghJFUFgtFlxf7f
         HqpuirxD5+y3GNLvsTzO1zuy7CU5iX67RJVRdj1Sl8iM7Ila5DtegvHYJhWVTnGW1ac7
         9ZLw==
X-Gm-Message-State: APjAAAVHrmu1Hb+DeSzdGvlwD57OPTaxyZ+fNVAmU9Nfo9y5aWQYXY5U
        Vuyt4fysxk0nRqKSNDOQqyiYnt2U
X-Google-Smtp-Source: APXvYqzyL8kTjGtcR++pPcs9ANuGnxDHT0tAGHOgrtlwfwi9WMj4o9ypMd4zkiIiErehXEddYM8iaA==
X-Received: by 2002:a17:902:9a07:: with SMTP id v7mr87847826plp.180.1558486175438;
        Tue, 21 May 2019 17:49:35 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:35 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 17/21] lpfc: Fix fcp_rsp_len checking on lun reset
Date:   Tue, 21 May 2019 17:49:07 -0700
Message-Id: <20190522004911.573-18-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Issuing a LUN reset was resulting in a command failure which then
escalated to a host reset.

The FCP-4 spec allows fcp_rsp_len field to specify the number of
valid bytes of FCP_RSP_INFO, and the value could be 4 or 8.
The driver is allowing only a value of 8, thus it failed the
command.

Revise the driver to allow 4 or 8

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 5a5a9bbe6023..f9df800e7067 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -4798,7 +4798,12 @@ lpfc_check_fcp_rsp(struct lpfc_vport *vport, struct lpfc_io_buf *lpfc_cmd)
 				 rsp_info,
 				 rsp_len, rsp_info_code);
 
-		if ((fcprsp->rspStatus2&RSP_LEN_VALID) && (rsp_len == 8)) {
+		/* If FCP_RSP_LEN_VALID bit is one, then the FCP_RSP_LEN
+		 * field specifies the number of valid bytes of FCP_RSP_INFO.
+		 * The FCP_RSP_LEN field shall be set to 0x04 or 0x08
+		 */
+		if ((fcprsp->rspStatus2 & RSP_LEN_VALID) &&
+		    ((rsp_len == 8) || (rsp_len == 4))) {
 			switch (rsp_info_code) {
 			case RSP_NO_FAILURE:
 				lpfc_printf_vlog(vport, KERN_INFO, LOG_FCP,
-- 
2.13.7

