Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E74D38DAF3
	for <lists+linux-scsi@lfdr.de>; Sun, 23 May 2021 13:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhEWLD3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 23 May 2021 07:03:29 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:41713 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhEWLD3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 23 May 2021 07:03:29 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d83 with ME
        id 8B1z2500421Fzsu03B1zsi; Sun, 23 May 2021 13:02:01 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 23 May 2021 13:02:01 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     skashyap@marvell.com, jhasan@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chad.dupuis@cavium.com,
        arun.easi@cavium.com, nilesh.javali@cavium.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] scsi: qedf: Fix an error handling path + cleanups
Date:   Sun, 23 May 2021 13:01:59 +0200
Message-Id: <cover.1621765056.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Patch 1/3 fixes a case where success is un-intentionaly returned.

The 2 other patches are clean-up.
Patch 2/3 is a clean-up in the same function, to improve its readability.
Pacth 3/3 is a proposal to both remove some lines of code and improve readability.

Christophe JAILLET (3):
  scsi: qedf: Fix an error handling path in 'qedf_alloc_global_queues()'
  scsi: qedf: Simplify 'qedf_alloc_global_queues()'
  scsi: qedf: Axe a few useless lines of code

 drivers/scsi/qedf/qedf_main.c | 102 +++++++++++++---------------------
 1 file changed, 38 insertions(+), 64 deletions(-)

-- 
2.30.2

