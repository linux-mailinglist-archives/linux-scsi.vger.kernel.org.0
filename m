Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 244B33639E
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 20:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfFESwJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 14:52:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38825 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFESwJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jun 2019 14:52:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id a186so14655991pfa.5
        for <linux-scsi@vger.kernel.org>; Wed, 05 Jun 2019 11:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dNMdMHcQcPWm8uzz70nOpgGhptKU++J1Y070n2KEUxQ=;
        b=MeWrqlMfNYUhAqhvPqmCru8AqUBGFrbIeSYPK/UyvP9CSLsrSSYQVrOfXeY+xEXfPa
         fJnHtexprEce3APoXmmiSAWcZor+dBoWYGwAsCNufz8G+Iu2xARzl0XK6S/Ebcypxyj6
         Fk9qCL2UYhzc42dDFdfK1Vxo0s3Cnayq1JqZG2eFRTLtdy2uDIJpouEVI6GFGGeqsZfq
         mriDA2oVqKmhHUbXPRqNr+mHsk7AKMW7cU61Jwq+RBgcxHc88w00kPF2nBPCfDHznzl4
         rCGL7b00WGyigwdTOmKiNgP6yNDUa+meVUpE6CdsFilE0Fad7yRyHvVMtckAMaJFviDi
         pLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dNMdMHcQcPWm8uzz70nOpgGhptKU++J1Y070n2KEUxQ=;
        b=Ugts5h1/5TU0A9GppzatGQMlC83t2DUlpTAojVvckn8Eb2vJWnklkuRBDzmc4jCAKA
         41ID58JXjROVj9CMADQNP2Jf7Ju1hJug7H8lAZJIKameMDnTBfgdbskauaNMijwo4D0Z
         5Kyy+gpe+5km7xcZ+gBSXFTMSq5BAw1q+CQlI7ZIaJLycGDYMSZMVQuX7EKMUFePEiX2
         KbMWiYv7jvmukb+QpKZJBm6ELQUxIIOpTK/IFyGGJrXHzmfA94kHCC8zGHtAVpE39hS3
         ufLzoWIBoPNXS+uQXdzBAYUcoR3kBl34/ZIzS/OClNSWzlsAFSlyeVzOsgtNjxUVIZXm
         J8Bg==
X-Gm-Message-State: APjAAAWSgDAJV2GzqDcCks4Av2HxpEFkefZf27t8czdyd2hqcUr9jVNQ
        da5NbnBr7712KFCRPE5PAwi2X1FPLdI=
X-Google-Smtp-Source: APXvYqyH2BhI1kCCDjQpmxtqeRRZs9L8tqTLVO8YADCiq0M244LYRJpEy+kXLTKMFr1DpFiQhPM/Qg==
X-Received: by 2002:a17:90a:cf12:: with SMTP id h18mr46611028pju.77.1559760728386;
        Wed, 05 Jun 2019 11:52:08 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id d9sm18414072pgj.34.2019.06.05.11.52.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 11:52:07 -0700 (PDT)
From:   Stephen Hemminger <stephen@networkplumber.org>
X-Google-Original-From: Stephen Hemminger <sthemmin@microsoft.com>
To:     linux-scsi@vger.kernel.org
Cc:     linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH] revert async probing of VMBus scsi device
Date:   Wed,  5 Jun 2019 11:52:05 -0700
Message-Id: <20190605185205.12583-1-sthemmin@microsoft.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Doing asynchronous probing can lead to reordered device names
which is leads to failed mounts.

Fixes: af0a5646cb8d ("use the new async probing feature for the hyperv drivers")
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 8472de1007ff..56dcaa43b652 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1942,9 +1942,6 @@ static struct hv_driver storvsc_drv = {
 	.id_table = id_table,
 	.probe = storvsc_probe,
 	.remove = storvsc_remove,
-	.driver = {
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-	},
 };
 
 #if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
-- 
2.20.1

