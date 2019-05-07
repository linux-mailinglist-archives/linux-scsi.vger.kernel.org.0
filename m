Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 061B7156EF
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 02:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEGA1p (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 May 2019 20:27:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41109 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfEGA1p (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 6 May 2019 20:27:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3so3595924pgp.8
        for <linux-scsi@vger.kernel.org>; Mon, 06 May 2019 17:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y6QT8G8Zvh34sZtJ9zx6eJf4Ww53EBYqzs/fzj6BGQU=;
        b=G/QzKfYvYqckLKNtagdnMJU0qt6AHZFTMf8Md4Zfx+wsuLIUens6k5ur568gyadqus
         1wW5UYxEqU+CHulzHdcrlKWzLSTcIz5I/LuIEDTRuc00gWXEJxMh8w5Fs0M3u2x9LWB1
         HV7BmdMVmGLSuKv1Q2yeXm2bdV6ytqzMZZuulGzUaF6PzSW3H0wz+ZtLm2jNCSO9NoQ0
         ij4QS/AdLidPbNk2XGx4pLbDHe3PL5NMqzAF0c+9NjfM1o8FQpl7v59lww3hhH7HTAg1
         0tgRwWES2CVmU+wyw9rMGI52bzHd+JIRqz4yj6t1KCGOEPu6TRUAKLqm/Cdo9+JkhcRY
         2/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y6QT8G8Zvh34sZtJ9zx6eJf4Ww53EBYqzs/fzj6BGQU=;
        b=tAjKyGu/cWAlxpkAYFizhudHRCcjQdr5IqUDevzn+SV5lu6NREse1KvGCMIKBjZzIs
         h/oQAI0ne5cderaJjVNd9AgvRT74oaxvDM58sNTD5mrAgGzlIYRbdBRFL30F+m/ghX9u
         S5U3Nr9Dz4e37ruRzwGD8TpQ30vbK7KFojq3B1b0GY/WuZh+1KSAIiBStx1zyG01p1XV
         aWuqwXUbYFLddpTOOm9XB3LIec9yWqiuHNNXqKIqrGORbHQf3DKttc9tbNX8ZI/Aao2d
         Fn9bCHLCbYsijgu2nys7gqCj8jyFtVn8AaKm/z9uIF7fvrr2/qL1wBtFBPC032ovCdd5
         kf8w==
X-Gm-Message-State: APjAAAUv67RoGcqZ1MAZvCcWdpaaW8OSQAibuLYQZ2oXJ1yYdz1aKOvB
        fJJP6R/QwGy7rqLJUkuv5WwqXkis
X-Google-Smtp-Source: APXvYqy0ChY7S1tQ5MK2f7C88Y2k5yWCJcUhFz1wAkoaMkPwdmep37FZRq2/khk7z8EFVGuTXaCMNA==
X-Received: by 2002:a63:170a:: with SMTP id x10mr35023016pgl.355.1557188864300;
        Mon, 06 May 2019 17:27:44 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id r8sm14756623pfn.11.2019.05.06.17.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 17:27:43 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH v2 4/4] lpfc: Update lpfc version to 12.2.0.2
Date:   Mon,  6 May 2019 17:26:50 -0700
Message-Id: <20190507002650.23210-5-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190507002650.23210-1-jsmart2021@gmail.com>
References: <20190507002650.23210-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Due to the couple of bug fixes, update lpfc version to 12.2.0.2

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_version.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_version.h b/drivers/scsi/lpfc/lpfc_version.h
index f7d9ef428417..220a932fe943 100644
--- a/drivers/scsi/lpfc/lpfc_version.h
+++ b/drivers/scsi/lpfc/lpfc_version.h
@@ -20,7 +20,7 @@
  * included with this package.                                     *
  *******************************************************************/
 
-#define LPFC_DRIVER_VERSION "12.2.0.1"
+#define LPFC_DRIVER_VERSION "12.2.0.2"
 #define LPFC_DRIVER_NAME		"lpfc"
 
 /* Used for SLI 2/3 */
-- 
2.13.7

