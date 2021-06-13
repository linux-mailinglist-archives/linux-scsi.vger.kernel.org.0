Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F193A570B
	for <lists+linux-scsi@lfdr.de>; Sun, 13 Jun 2021 10:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhFMIYt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 13 Jun 2021 04:24:49 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:33186 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFMIYt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 13 Jun 2021 04:24:49 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d41 with ME
        id GYNl2500P21Fzsu03YNmao; Sun, 13 Jun 2021 10:22:47 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 13 Jun 2021 10:22:47 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] scsi: mptbase: switch from 'pci_' to 'dma_' API
Date:   Sun, 13 Jun 2021 10:22:43 +0200
Message-Id: <cover.1623571676.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In order to convert this file to the dma_ API, 3 steps are proposed.

The first one is purely mechanical. All the updated memory allocations can
use GFP_KERNEL because of 'mpt_config()' calls. This function can sleep so
it sounds like a reasonable assumption to use GFP_KERNEL.

The 2nd patch may be discussed further. GFP_ATOMIC is needed because at least
one of the caller might sleep.
But if we want to avoid GFP_ATOMIC as much as possible, the 'sleepFlag' could
be passed in order to use the "right" flag. All other callers would need to
be invistigated to see if GFP_ATOMIC or GFP_KERNEL is needed.

The 3rd patch is just a clean up. When 'dma_set_mask_and_coherent' can be
used, it is less verbose than 'dma_set_mask()/dma_set_coherent_mask()'.
In this patch, look at the comment below ---, because the code looks
spurious to me, but as I know neither this hardware, nor the "1078 errata",
I'll let anyone that understand this this code to send the correct fix, if
needed.

Christophe JAILLET (3):
  scsi: mptbase: switch from 'pci_' to 'dma_' API
  scsi: mptbase: switch from 'pci_' to 'dma_' API in 'mpt_alloc_fw_memory()'
  scsi: mptbase: use 'dma_set_mask_and_coherent()' to simplify code

 drivers/message/fusion/mptbase.c | 151 +++++++++++++++++--------------
 1 file changed, 82 insertions(+), 69 deletions(-)

-- 
2.30.2

