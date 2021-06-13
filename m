Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4823A5A81
	for <lists+linux-scsi@lfdr.de>; Sun, 13 Jun 2021 23:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhFMVGL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 13 Jun 2021 17:06:11 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:45537 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhFMVGK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 13 Jun 2021 17:06:10 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d46 with ME
        id Gl462500721Fzsu03l467y; Sun, 13 Jun 2021 23:04:07 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 13 Jun 2021 23:04:07 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/1] scsi: mptctl: switch from 'pci_' to 'dma_' API
Date:   Sun, 13 Jun 2021 23:04:04 +0200
Message-Id: <cover.1623617903.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This cover letter is only there to draw attention on the fact that I'm a bit
unsure about the use of GFP_KERNEL in 'kbuf_alloc_2_sgl()'.

In all conversion that I've done, GFP_USER was never used. I don't fully
understand the difference between GFP_USER and GFP_KERNEL.

So please review with care :).


For the 3 other functions, I'm much more confident. I've put the explanation
of why I think that GFP_KERNEL is safe in patch 1/1.
Basically, these functions already call fome functions that can sleep.


Christophe JAILLET (1):
  scsi: mptctl: switch from 'pci_' to 'dma_' API

 drivers/message/fusion/mptctl.c | 82 ++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 33 deletions(-)

-- 
2.30.2

