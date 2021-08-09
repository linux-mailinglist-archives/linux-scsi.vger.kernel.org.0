Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EFF3E4FD1
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Aug 2021 01:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbhHIXFI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 9 Aug 2021 19:05:08 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:45987 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbhHIXFC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 9 Aug 2021 19:05:02 -0400
Received: by mail-pl1-f175.google.com with SMTP id d17so18326197plr.12
        for <linux-scsi@vger.kernel.org>; Mon, 09 Aug 2021 16:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KAGONwU2Ix3aXwytjxc1FfNzoxkRboKLNCgioIOWq0o=;
        b=pY8b/PWnTtQY88Gv5fVWtl0YcuTvyH7jZV7m1/XGQFSv2+dUjCg7sDiHwWDbbk0HxH
         IIcSRN6E3ztFXYR/6U7eXqoGzmJEwSiSKVseoCbXozDloMvB0nrik/YosQ3ANBM/GIzr
         2jZArdVsYgQqd3gwg0mSNabrEfOGqaX2+VX+w0O5EZb7H8GzFqEQc7GwCp6jLYsd3DT1
         O7P9Nh1hD+wttneIZxxPTJJ/SmmK6a6sy6kMWPHjmGJRaxpCgCwnMZuaAiFaq6k9AJlo
         /XM7Cj24w6Ad7OrEPFEfe11S6+u6a0jr57gb3YCQXpK6HbJUETL21wTOV/bQ+c4uhGdI
         TfCg==
X-Gm-Message-State: AOAM533MS+4HxxX3CNC0WfTG/wfPUK6vWcOapDGUI+UlmdS11zEDwP/4
        3xF3yJux5g4P8/vvD1BeMeY=
X-Google-Smtp-Source: ABdhPJzhtlRJYvhv6Dqppbl6j34WJBqdHmD3pDK+U3S7+/wRlhpANCIsO1tJaNycmkwIPJwYMgZrjg==
X-Received: by 2002:a62:1982:0:b029:356:3484:b7ec with SMTP id 124-20020a6219820000b02903563484b7ecmr26349992pfz.48.1628550281268;
        Mon, 09 Aug 2021 16:04:41 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:7dd4:e46e:368b:7454])
        by smtp.gmail.com with ESMTPSA id j6sm24102260pgq.0.2021.08.09.16.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 16:04:40 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v5 25/52] ips: Use scsi_cmd_to_rq() instead of scsi_cmnd.request
Date:   Mon,  9 Aug 2021 16:03:28 -0700
Message-Id: <20210809230355.8186-26-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210809230355.8186-1-bvanassche@acm.org>
References: <20210809230355.8186-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Prepare for removal of the request pointer by using scsi_cmd_to_rq()
instead. This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/ips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index 8b33c9871484..cdd94fb2aab7 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -3735,7 +3735,7 @@ ips_send_cmd(ips_ha_t * ha, ips_scb_t * scb)
 		scb->cmd.dcdb.segment_4G = 0;
 		scb->cmd.dcdb.enhanced_sg = 0;
 
-		TimeOut = scb->scsi_cmd->request->timeout;
+		TimeOut = scsi_cmd_to_rq(scb->scsi_cmd)->timeout;
 
 		if (ha->subsys->param[4] & 0x00100000) {	/* If NEW Tape DCDB is Supported */
 			if (!scb->sg_len) {
