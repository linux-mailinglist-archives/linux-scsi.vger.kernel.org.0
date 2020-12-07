Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030CC2D18F6
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Dec 2020 20:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgLGTCh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 7 Dec 2020 14:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLGTCh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 7 Dec 2020 14:02:37 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6ADC06179C;
        Mon,  7 Dec 2020 11:01:50 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id bo9so20958636ejb.13;
        Mon, 07 Dec 2020 11:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9XWsbQy0TPa1aqPVd9WuvjAu25u6vHribCzLOiWr0qE=;
        b=ToSOox4iDDgruYgaBWutGWvGKGd5lfQXvLL694MO3qGwbcvjcQYju5NJQ2m7igqFxe
         wIX3b7+HfhPwnudha53y0stbbtEr43IVRqs1z9+mMqnvvXUVdHIa57kH3I0TqjgEZo8e
         2Mnr9LUAJkUaz+dBdhl40PGHnav5T4pGqlLXEvOjhBegC95rVv3Z/zvqR/9xk3YseHqj
         1BzpfqtTih82+o588Jm7H+33BVcAfO9ssuGNoGEi8Szivx+/yIxdomZl3DrxhQfSAi8A
         BB5H1NBNv7/3VAnmvX/tXcYPdLrcx0afCoakcBCxHFtgf0lUom4ZMuYYchi3S6+S+43z
         s8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9XWsbQy0TPa1aqPVd9WuvjAu25u6vHribCzLOiWr0qE=;
        b=NDT+CWoCTVbb/N4jyuq7iww2GvvIwEguBaAKLPRLpd3hYrDGH3dcshqAuZYP/x/Du6
         +GSlIKSLLbz5njxaegFzJCAvEiWp0/cgzi54oG1RFSYKAjO5oRU1UsuUW8iyDqtQP/q0
         ytfUGcb6dOF3xbi2JpZ5T6wTjS83ylqwLZP4qL6dTR2gbs0c20LL+BT2bSTSYd6eQMFE
         Vw/rxI9BR0ukMcn9dsnCNXc0ueUGlMl8tkmY5maWwrngSZYGJdBhy49xj2o/Ux4Fnx8b
         QkJZKe98Gp6kC44AjeSFl216JBq9r1NAfDZdRJpkBKQ+Ykshv2bvAC3d9MFUkrEfiDMk
         UraQ==
X-Gm-Message-State: AOAM5312b10l64bbI8QpoRX4kLY2dwIFbJ2/7+nOscCpgQXqmvv9mEpA
        iQI63t96ucvc6KFZSnXD3q3e8ebPPtM=
X-Google-Smtp-Source: ABdhPJw8okOPAN6pgAOxw4EJ1GnP9xZ/0pWLPLdfIcOOb7ob2CvKfB8/v00OudRLjB9GyHJL6ihlxg==
X-Received: by 2002:a17:906:1c8e:: with SMTP id g14mr20180191ejh.5.1607367709494;
        Mon, 07 Dec 2020 11:01:49 -0800 (PST)
Received: from localhost.localdomain (ip5f5bfce9.dynamic.kabel-deutschland.de. [95.91.252.233])
        by smtp.gmail.com with ESMTPSA id b9sm13479631eju.8.2020.12.07.11.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:01:49 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scsi: ufs: Fix wrong print message in dev_err()
Date:   Mon,  7 Dec 2020 20:01:37 +0100
Message-Id: <20201207190137.6858-3-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201207190137.6858-1-huobean@gmail.com>
References: <20201207190137.6858-1-huobean@gmail.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Change dev_err() print message from "dme-reset" to "dme_enable" in function
ufshcd_dme_enable().

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 5b2219e44743..f8f5eddad506 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3645,7 +3645,7 @@ static int ufshcd_dme_enable(struct ufs_hba *hba)
 	ret = ufshcd_send_uic_cmd(hba, &uic_cmd);
 	if (ret)
 		dev_err(hba->dev,
-			"dme-reset: error code %d\n", ret);
+			"dme-enable: error code %d\n", ret);
 
 	return ret;
 }
-- 
2.17.1

