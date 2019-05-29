Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F672E61B
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfE2U2s (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:28:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41148 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2U2s (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:28:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id q17so2364350pfq.8
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eLWafzqtz9yFUQMik2Y2HxLVRK0uZOG5Mp1liJ8awX8=;
        b=YkuUSVhUCZ7baopynP1cYS0aW6mbsGUfCASBnge2hQapu6iXyk9QABRPP46YKn8GyG
         o4c3BTQw/OwcIFW/zLEE6eNMUOgL/tp0M0yglU20nZnwJRit/TaXD/x/rFSKF8VDU2CA
         kiVhmLchB6tpIddXVl1w3HsJORTVAAUB3C2W36xB1JwxcDmWH2CyCPDoindi1tpv1Jxe
         01Ltimx3cOsCuBijx+8N/LMF4jAs2C5XrmetS8pxABbllNJboy/cpZAmhiqjZHhXabY1
         9Sg9xiFJtM+kdAporFFEPKrF6jBfKm5pTW3GCbBy7D3X6wRyFVCiV9FMixGtMmMtVV0R
         8nSg==
X-Gm-Message-State: APjAAAV/zPxWj9GDJS1EAMK+y0ggkI4Z51aKhSN0Swg1JluMJwx3IQEf
        vjZIu+wUcz8/uD+V4Jst2A0=
X-Google-Smtp-Source: APXvYqxUEeuSy78JnaWzHl+e+TwTLKD3VSjimcPX31eykFdqL+i2QLCORCMNMnVZh5JmxcREjkQktA==
X-Received: by 2002:a63:1106:: with SMTP id g6mr2360018pgl.83.1559161727381;
        Wed, 29 May 2019 13:28:47 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:28:46 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 08/20] qla2xxx: Declare qla_tgt_cmd.cdb const
Date:   Wed, 29 May 2019 13:28:14 -0700
Message-Id: <20190529202826.204499-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
References: <20190529202826.204499-1-bvanassche@acm.org>
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
index 89ceffa7d4fd..8e820182a301 100644
--- a/drivers/scsi/qla2xxx/qla_target.h
+++ b/drivers/scsi/qla2xxx/qla_target.h
@@ -921,7 +921,7 @@ struct qla_tgt_cmd {
 	uint8_t scsi_status, sense_key, asc, ascq;
 
 	struct crc_context *ctx;
-	uint8_t		*cdb;
+	const uint8_t	*cdb;
 	uint64_t	lba;
 	uint16_t	a_guard, e_guard, a_app_tag, e_app_tag;
 	uint32_t	a_ref_tag, e_ref_tag;
-- 
2.22.0.rc1

