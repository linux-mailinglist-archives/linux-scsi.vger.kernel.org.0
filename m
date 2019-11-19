Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2BD3102D3C
	for <lists+linux-scsi@lfdr.de>; Tue, 19 Nov 2019 21:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfKSUI1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 19 Nov 2019 15:08:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39682 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfKSUI1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 19 Nov 2019 15:08:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id t26so5289123wmi.4;
        Tue, 19 Nov 2019 12:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KCp04SO08u0mriK7qTV+FETiFzUDNrc3ZT4Yx/eQ8E0=;
        b=A/Zn6OswfbbjmUzISELFwRgou3oNBNdIhIFsLRUEEw6wzcpy88kh+C4M9U0+8SXcbm
         TyJhJQFlds5YO+If0xaRMvGo0t+4vJKx5SGEe4zIdb7/IFrzozPBRMioIVJ4jAMkC72x
         j7KCEAbZ0uiSLrgxQdmJz9oXLKLCXBm0EBMl8Yx6QA+gZvzgMTjl5Ttt+n/GN5J9YJef
         oUV7QDl92l5iP1cpKNp5YEgzdn8JfpkcfrP+q0j50w366aC6hdANLBqW7Q5o3P+LVsPj
         dHeZwYbNo/hdQeuFM6Qu/5BjT/k80XrQRAuxh1UeGxy/QPnQokXHW/lKKJOFnvAmdP8L
         3fFA==
X-Gm-Message-State: APjAAAWwxSwv+y63b/lNF/4zW+GOGkxjD+oDchslgva23+/3SYgQjulA
        smQ6TOwWi/J7XfOjvaSZJ1o=
X-Google-Smtp-Source: APXvYqxxJvgZ6N4TWyD3FhEYdeHS+5u7gmWpIt6BwZqmOrBZmtvvuakmmQcHygO2gRH3cFQlo9p05A==
X-Received: by 2002:a1c:6a09:: with SMTP id f9mr8133234wmc.15.1574194102495;
        Tue, 19 Nov 2019 12:08:22 -0800 (PST)
Received: from localhost.localdomain (2001-1c06-18c6-e000-0168-2a5e-b9ec-4e8e.cable.dynamic.v6.ziggo.nl. [2001:1c06:18c6:e000:168:2a5e:b9ec:4e8e])
        by smtp.gmail.com with ESMTPSA id q5sm4114445wmc.27.2019.11.19.12.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 12:08:21 -0800 (PST)
From:   Kars de Jong <jongk@linux-m68k.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>
Cc:     linux-scsi@vger.kernel.org, linux-m68k@vger.kernel.org,
        schmitzmic@gmail.com, fthain@telegraphics.com.au,
        Kars de Jong <jongk@linux-m68k.org>
Subject: [PATCH v4 1/2] esp_scsi: Correct ordering of PCSCSI definition in esp_rev enum
Date:   Tue, 19 Nov 2019 21:08:04 +0100
Message-Id: <20191119200805.28319-2-jongk@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119200805.28319-1-jongk@linux-m68k.org>
References: <20191119200805.28319-1-jongk@linux-m68k.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The order of the definitions in the esp_rev enum is important. The values
are used in comparisons for chip features.

Add a comment to the enum explaining this.

Also, the actual values for the enum fields are irrelevant, so remove the
explicit values (suggested by Geert Uytterhoeven). This makes adding a new
field in the middle of the enum easier.

Finally, move the PCSCSI definition to the right place in the enum. In its
previous location, at the end of the enum, the wrong values are written to
the CONFIG3 register when used with FAST-SCSI targets.

Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
---
 drivers/scsi/esp_scsi.c |  2 +-
 drivers/scsi/esp_scsi.h | 17 +++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index bb88995a12c7..4fc3eee3138b 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -2373,10 +2373,10 @@ static const char *esp_chip_names[] = {
 	"ESP100A",
 	"ESP236",
 	"FAS236",
+	"AM53C974",
 	"FAS100A",
 	"FAST",
 	"FASHME",
-	"AM53C974",
 };
 
 static struct scsi_transport_template *esp_transport_template;
diff --git a/drivers/scsi/esp_scsi.h b/drivers/scsi/esp_scsi.h
index 91b32f2a1a1b..f764d64e1f25 100644
--- a/drivers/scsi/esp_scsi.h
+++ b/drivers/scsi/esp_scsi.h
@@ -257,15 +257,16 @@ struct esp_cmd_priv {
 };
 #define ESP_CMD_PRIV(CMD)	((struct esp_cmd_priv *)(&(CMD)->SCp))
 
+/* NOTE: this enum is ordered based on chip features! */
 enum esp_rev {
-	ESP100     = 0x00,  /* NCR53C90 - very broken */
-	ESP100A    = 0x01,  /* NCR53C90A */
-	ESP236     = 0x02,
-	FAS236     = 0x03,
-	FAS100A    = 0x04,
-	FAST       = 0x05,
-	FASHME     = 0x06,
-	PCSCSI     = 0x07,  /* AM53c974 */
+	ESP100,  /* NCR53C90 - very broken */
+	ESP100A, /* NCR53C90A */
+	ESP236,
+	FAS236,
+	PCSCSI,  /* AM53c974 */
+	FAS100A,
+	FAST,
+	FASHME,
 };
 
 struct esp_cmd_entry {
-- 
2.17.1

