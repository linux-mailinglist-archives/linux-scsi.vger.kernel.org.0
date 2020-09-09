Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD16263282
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Sep 2020 18:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbgIIQpC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Sep 2020 12:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730987AbgIIQoz (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 9 Sep 2020 12:44:55 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED6D32166E;
        Wed,  9 Sep 2020 16:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599669895;
        bh=Fh0fYO6W4eJejAehQe91VaJokQFPRSJs+BT7rxkuW68=;
        h=From:To:Cc:Subject:Date:From;
        b=s3Ikb7x5NwtLDVue2TQd7kP87RCc/mUc4HGwjFJvsYQX2Nok7n/DCSQrADeMrZaBC
         7BHWekOQSnHB+eceVb4b3T4uSYvuAV6kpcnErm6dVFUvjVf96YQf0olIGQottuo152
         rS8R90u6tUeF4rFrdtagxFd+M7u4NJtbKvmZEKcM=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] MAINTAINERS: Drop megaraidlinux.pdl@broadcom.com from MEGARAID SCSI/SAS DRIVERS
Date:   Wed,  9 Sep 2020 11:44:46 -0500
Message-Id: <20200909164446.713025-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Every post to megaraidlinux.pdl@broadcom.com seems to generate a bounce, so
I think the list is defunct.  Remove it from MAINTAINERS.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..a92d1517e865 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11042,7 +11042,6 @@ MEGARAID SCSI/SAS DRIVERS
 M:	Kashyap Desai <kashyap.desai@broadcom.com>
 M:	Sumit Saxena <sumit.saxena@broadcom.com>
 M:	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
-L:	megaraidlinux.pdl@broadcom.com
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
 W:	http://www.avagotech.com/support/
-- 
2.25.1

