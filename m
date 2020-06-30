Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FF720FF82
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2020 23:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgF3Vui (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Jun 2020 17:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgF3Vuh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Jun 2020 17:50:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C112C061755
        for <linux-scsi@vger.kernel.org>; Tue, 30 Jun 2020 14:50:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 17so21011005wmo.1
        for <linux-scsi@vger.kernel.org>; Tue, 30 Jun 2020 14:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4/5wtHumu/ck9fbHHEicbnbDStQQlMLoW5+JXxDji08=;
        b=ZeTBOMgeyEnJMsL8Zzzykne1T4ShsyLvQ5K40JtCWAoQ3aq+aLL7t+DgRcE7UOY6XU
         I9NzUoYwrYOJyNgdHfuodeyNQBa/+AN2Uv+XzEcEL79Z5+hxNjN9449ePmT39P3hDHdR
         Uw9byYeyJ+npA7o6zM7nGqsTXZbfU8MQsr3qmIHRjt+6OnMAeJVUvyTtvniqLn73AG87
         ksCfaIXVE3PUZlaIoOMTz+YJpFQCoqod+u5rnruMrqjKd9dYTtZX81f7CFT0YwOJf+U0
         gvkAvZ6Xf2LG9GTwBTMyLjKjPW110MRlxO979nthJtkTLW0HBOa/Qqiv2NuaGggJYOPy
         ulAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4/5wtHumu/ck9fbHHEicbnbDStQQlMLoW5+JXxDji08=;
        b=BXO0SmCGLDWRH5E6+Pk/2G2rQkxOvRcKGwe/wZzVrDMRHTm+LuMc3cN8XQAybwNp5b
         yiwnzNMAkVENBOggvDJ0qWKi444SPVYxEje+jvjmPPi64FzLDVfeuASP5SSLV6ugRsiz
         9UeCgIb1WkI7+m2S4FjvEbZLhHr4aD2EzzBonk787JQ56m9Vyn1cXpbfbb1px5huGLmi
         We4tkZKmbp8nQRHNXebN/kAC0mH5Jop9TTmndEOFQN2UTcG0K8kUVsFcnMoZJJTy64CB
         zOVbvh43TnGqX03zUgyufeuUfRNveNMRM1bdF8F5h1X4mkqyXqvfijhHZPjWc5KBFd0P
         druw==
X-Gm-Message-State: AOAM532v/Ln8ARAyiM7Z+2DZLZmUtrMbjWbGrNC0kWuQdF800c1tnYXI
        iWuL/Iusln64itW3jAeuIIdhx8v8
X-Google-Smtp-Source: ABdhPJw012CEfXtkcX/2efOTm67ff+CG0z1maj/BnpPoo8xV0LEHk6GWLN+IF7tIFhmu2W0Lz02YkQ==
X-Received: by 2002:a1c:f219:: with SMTP id s25mr242877wmc.2.1593553835842;
        Tue, 30 Jun 2020 14:50:35 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f14sm5518551wro.90.2020.06.30.14.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 14:50:35 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 14/14] lpfc: Update lpfc version to 12.8.0.2
Date:   Tue, 30 Jun 2020 14:50:01 -0700
Message-Id: <20200630215001.70793-15-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200630215001.70793-1-jsmart2021@gmail.com>
References: <20200630215001.70793-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Update lpfc version to 12.8.0.2

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_version.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_version.h b/drivers/scsi/lpfc/lpfc_version.h
index ab0bc26c098d..1987c6666279 100644
--- a/drivers/scsi/lpfc/lpfc_version.h
+++ b/drivers/scsi/lpfc/lpfc_version.h
@@ -20,7 +20,7 @@
  * included with this package.                                     *
  *******************************************************************/
 
-#define LPFC_DRIVER_VERSION "12.8.0.1"
+#define LPFC_DRIVER_VERSION "12.8.0.2"
 #define LPFC_DRIVER_NAME		"lpfc"
 
 /* Used for SLI 2/3 */
-- 
2.25.0

