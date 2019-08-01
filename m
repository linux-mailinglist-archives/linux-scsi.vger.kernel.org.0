Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 761DE7E199
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388001AbfHAR4z (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43213 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR4y (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so25549813pld.10
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N149Ca7fFuw0msPPiUHQF7XLTmkXzIBAW2Yrv5QlOMU=;
        b=qyk/FYo6MJQURPc73HfvFcDXBKnVgTYD+bQZQ8+VORddH+ieoV2pwXA+IfxTvZ8IRO
         37ESbaLCYW5kv09obUKJAO6Ky5notdSE/I2e1lf4AdpNCo0gRIKTX9PvXKzE5cpwsqAU
         2HSxVuQgTsYlI0a/ecxiXx9NRm+Dp8lSIRwqzi19u9chgD3zUKkHtDDSdr20Rc/bJeWD
         NEGXDgM+IsS4FOqZwHWTraWzHzpxAB22LGc8+9f1jdc2z4h3AHdFptBFE0ceiprIIVJa
         efWpM8N7PnG/26OVcj4er6/WWMgDQHY4FoeNX2e7h/e6dmTTmBDdM+JkQdrKUbW2u/ak
         bOFw==
X-Gm-Message-State: APjAAAWMEf3AC8U3y5TxM/NY/YL5vm7budtC+PdNDs53y8Rc4hifpxXW
        FzAVjrfIBL1c5C5LQLwOJg8=
X-Google-Smtp-Source: APXvYqzlcC+swwItplNe5pMEtkeZqTPzZVSahYlHVrgYpE49nqgjlaGhouwYMZM4qPjXOOe4rsCRsA==
X-Received: by 2002:a17:902:2987:: with SMTP id h7mr32818898plb.37.1564682214081;
        Thu, 01 Aug 2019 10:56:54 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:53 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 24/59] qla2xxx: Complain if parsing the version string fails
Date:   Thu,  1 Aug 2019 10:55:39 -0700
Message-Id: <20190801175614.73655-25-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch fixes a Coverity complaint about not checking the sscanf()
return value.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_tmpl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_tmpl.c b/drivers/scsi/qla2xxx/qla_tmpl.c
index de696a07532e..7ed481dd8ee6 100644
--- a/drivers/scsi/qla2xxx/qla_tmpl.c
+++ b/drivers/scsi/qla2xxx/qla_tmpl.c
@@ -860,8 +860,9 @@ qla27xx_driver_info(struct qla27xx_fwdt_template *tmp)
 {
 	uint8_t v[] = { 0, 0, 0, 0, 0, 0 };
 
-	sscanf(qla2x00_version_str, "%hhu.%hhu.%hhu.%hhu.%hhu.%hhu",
-	    v+0, v+1, v+2, v+3, v+4, v+5);
+	WARN_ON_ONCE(sscanf(qla2x00_version_str,
+			    "%hhu.%hhu.%hhu.%hhu.%hhu.%hhu",
+			    v+0, v+1, v+2, v+3, v+4, v+5) != 6);
 
 	tmp->driver_info[0] = v[3] << 24 | v[2] << 16 | v[1] << 8 | v[0];
 	tmp->driver_info[1] = v[5] << 8 | v[4];
-- 
2.22.0.770.g0f2c4a37fd-goog

