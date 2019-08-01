Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2EC7E18C
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387967AbfHAR4i (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46164 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfHAR4h (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id k189so15573093pgk.13
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QgaAPqHCuAebR7KTll3bZoY3ldcKLtsTQeQhackzy7k=;
        b=Q1rvmTS0LuiMe22KjDc62/y4B7zBFbOzGKI+YyiNzUeDBhRMVXAVpRJ2EAVnaa4ZEW
         F6rlLevFLhbowh2eAjty9jDmNb6kR94a0UJaymZiGEdE9Op9z4L8B0/iiPxQQOLy8mis
         XuV/IkabFzc9fsYL8aBZuL3HVHS5MNBHoIeQeAS8E3qvwmoI8JQAcAvs5QJ7qn/BXRyw
         svek/I4XaIroO54Scs+oc0o+6VQfViDMqkGhWGHWnnZ1cEf5OZg8KQRhTrcIH1zVTUsP
         6XNkoDonzcQ/SS0WgQE3LrhA6XH8w8eqlSJqhJhcE+F9Q+3RFybjFOyZJ3qK3zFSXMUA
         jnyw==
X-Gm-Message-State: APjAAAUeFvG2hMJjVdUFbHKayC+U9eMUzK/e6kWaVJzQAbQ1EliB3OdY
        a7KrWvgdRb5iezFxQb8ggQo=
X-Google-Smtp-Source: APXvYqy9wqamR1Bp0eOiXcwE5xLonSneZtR0IcSFXLlOkCPIJiRidLVFe+B7wQivvDgH0eqdhu/tyQ==
X-Received: by 2002:a17:90a:ba94:: with SMTP id t20mr59277pjr.8.1564682197049;
        Thu, 01 Aug 2019 10:56:37 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:36 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 11/59] qla2xxx: Declare qla_tgt_cmd.cdb const
Date:   Thu,  1 Aug 2019 10:55:26 -0700
Message-Id: <20190801175614.73655-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Make it clear that the CDB is not modified after processing of a SCSI
command has started.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_target.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.h b/drivers/scsi/qla2xxx/qla_target.h
index b8d244f1e189..29d98757acff 100644
--- a/drivers/scsi/qla2xxx/qla_target.h
+++ b/drivers/scsi/qla2xxx/qla_target.h
@@ -912,7 +912,7 @@ struct qla_tgt_cmd {
 	uint8_t scsi_status, sense_key, asc, ascq;
 
 	struct crc_context *ctx;
-	uint8_t		*cdb;
+	const uint8_t	*cdb;
 	uint64_t	lba;
 	uint16_t	a_guard, e_guard, a_app_tag, e_app_tag;
 	uint32_t	a_ref_tag, e_ref_tag;
-- 
2.22.0.770.g0f2c4a37fd-goog

