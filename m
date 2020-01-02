Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E45B12F07F
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jan 2020 23:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgABWVF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 Jan 2020 17:21:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:39582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728931AbgABWVD (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 2 Jan 2020 17:21:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6FC021582;
        Thu,  2 Jan 2020 22:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003663;
        bh=IMSOtqcwaP6UlIqYmPsM13lnT/jot8oLkrsfRUmghbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sPoP68wSNv3TPcxrz0YtV6+MFhpfCkgOgQ0P0pVX3MchcJ1eYhtbGWvzkZCEIGJc1
         XdbTICVQ74SGTyaFy3MNSUG55x45bUYXtIjNinjvRpaeasK61T7PTJ6FTq0+lz2xvF
         L9TqbxOO8jbhzg0Eu5TLLt8eifw18SBWnq1bIx+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-scsi@vger.kernel.org,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 063/114] cdrom: respect device capabilities during opening action
Date:   Thu,  2 Jan 2020 23:07:15 +0100
Message-Id: <20200102220035.429538902@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220029.183913184@linuxfoundation.org>
References: <20200102220029.183913184@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Diego Elio Pettenò <flameeyes@flameeyes.com>

[ Upstream commit 366ba7c71ef77c08d06b18ad61b26e2df7352338 ]

Reading the TOC only works if the device can play audio, otherwise
these commands fail (and possibly bring the device to an unhealthy
state.)

Similarly, cdrom_mmc3_profile() should only be called if the device
supports generic packet commands.

To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Diego Elio Pettenò <flameeyes@flameeyes.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cdrom/cdrom.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 933268b8d6a5..d3947388a3ef 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -996,6 +996,12 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
 	tracks->xa = 0;
 	tracks->error = 0;
 	cd_dbg(CD_COUNT_TRACKS, "entering cdrom_count_tracks\n");
+
+	if (!CDROM_CAN(CDC_PLAY_AUDIO)) {
+		tracks->error = CDS_NO_INFO;
+		return;
+	}
+
 	/* Grab the TOC header so we can see how many tracks there are */
 	ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCHDR, &header);
 	if (ret) {
@@ -1162,7 +1168,8 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
 		ret = open_for_data(cdi);
 		if (ret)
 			goto err;
-		cdrom_mmc3_profile(cdi);
+		if (CDROM_CAN(CDC_GENERIC_PACKET))
+			cdrom_mmc3_profile(cdi);
 		if (mode & FMODE_WRITE) {
 			ret = -EROFS;
 			if (cdrom_open_write(cdi))
@@ -2882,6 +2889,9 @@ int cdrom_get_last_written(struct cdrom_device_info *cdi, long *last_written)
 	   it doesn't give enough information or fails. then we return
 	   the toc contents. */
 use_toc:
+	if (!CDROM_CAN(CDC_PLAY_AUDIO))
+		return -ENOSYS;
+
 	toc.cdte_format = CDROM_MSF;
 	toc.cdte_track = CDROM_LEADOUT;
 	if ((ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCENTRY, &toc)))
-- 
2.20.1



