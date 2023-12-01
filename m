Return-Path: <linux-scsi+bounces-391-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8088002A1
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 05:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530F428148C
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 04:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19399C135
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 04:35:04 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 1AA52171D;
	Thu, 30 Nov 2023 19:00:27 -0800 (PST)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 3B42560105E64;
	Fri,  1 Dec 2023 11:00:16 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: dan.carpenter@linaro.org,
	hare@suse.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com
Cc: Su Hui <suhui@nfschina.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2 0/3] scsi: aic7xxx: fix some problem of return value
Date: Fri,  1 Dec 2023 10:59:53 +0800
Message-Id: <20231201025955.1584260-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 - fix some problems and split v1 patch into this patch set.(Thanks to
   Dan)

v1:
 - https://lore.kernel.org/all/20231130024122.1193324-1-suhui@nfschina.com/

Su Hui (3):
  scsi: aic7xxx: return negative error codes in
    ahc_linux_register_host()
  scsi: aic7xxx: return ahc_linux_register_host()'s value rather than
    zero
  scsi: aic7xxx: return negative error codes in aic7770_probe()

 drivers/scsi/aic7xxx/aic7770_osm.c     | 6 +++---
 drivers/scsi/aic7xxx/aic7xxx_osm.c     | 2 +-
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c | 3 +--
 3 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.30.2


