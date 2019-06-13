Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E200C4448C
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Jun 2019 18:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392647AbfFMQhc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jun 2019 12:37:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730638AbfFMHN7 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Jun 2019 03:13:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9AC15AFF8;
        Thu, 13 Jun 2019 07:13:50 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A55F5D9C8;
        Thu, 13 Jun 2019 07:13:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        "Juergen E . Fischer" <fischer@norbit.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 00/15] scsi: use sg helper to operate sgl
Date:   Thu, 13 Jun 2019 15:13:20 +0800
Message-Id: <20190613071335.5679-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 13 Jun 2019 07:13:58 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

Most of drivers use sg helpers to operate sgl, however there is
still a few drivers which operate sgl directly, this way can't
work in case of chained sgl.

So convert them to use sg helper.

There are two types of scsi SGL uses:

1) operate on scsi_sglist(scmd) directly, then one local variable of
'struct scatterlist *' is involved, so the following coccinelle semantic
patch is developed for finding this type of direct sgl uses:

	https://marc.info/?l=linux-scsi&m=156031374809852&w=2

2) scsi_sglist(scmd) is stored to cmd->SCp.buffer and the SGL is used
via cmd->SCp.buffer. Simple 'grep SCp.buffer' is used for finding SGL
direct uses, fortunately only the following drivers uses SCp.buffer to
store SGL:

	NCR5380, aha152x, arm/, imm, pcmcia, ppa and wd33c93

And arm/ is already ready to handle chained SGL.

The 1st 9 patches are for handling type #1, and the other 6 patches
for handling type #2.

V2:
	- use coccinelle semantic patch for finding direct sgl uses from
	scsi command(9 drivers found)
	- run 'git grep -E "SCp.buffer"' to find direct sgl uses
	from SCp.buffer(6 drivers are found)

Finn Thain (1):
  NCR5380: Support chained sg lists

Ming Lei (14):
  scsi: vmw_pscsi: use sg helper to operate sgl
  scsi: advansys: use sg helper to operate sgl
  scsi: lpfc: use sg helper to operate sgl
  scsi: mvumi: use sg helper to operate sgl
  scsi: ipr: use sg helper to operate sgl
  scsi: pmcraid: use sg helper to operate sgl
  usb: image: microtek: use sg helper to operate sgl
  staging: unisys: visorhba: use sg helper to operate sgl
  s390: zfcp_fc: use sg helper to operate sgl
  scsi: aha152x: use sg helper to operate sgl
  scsi: imm: use sg helper to operate sgl
  scsi: pcmcia: nsp_cs: use sg helper to operate sgl
  scsi: ppa: use sg helper to operate sgl
  scsi: wd33c93: use sg helper to operate sgl

 drivers/s390/scsi/zfcp_fc.c                   |  4 +-
 drivers/scsi/NCR5380.c                        | 41 ++++++++-----------
 drivers/scsi/advansys.c                       |  2 +-
 drivers/scsi/aha152x.c                        | 29 ++++++++-----
 drivers/scsi/imm.c                            |  2 +-
 drivers/scsi/ipr.c                            | 28 +++++++------
 drivers/scsi/lpfc/lpfc_nvmet.c                |  3 +-
 drivers/scsi/mvumi.c                          |  9 ++--
 drivers/scsi/pcmcia/nsp_cs.c                  |  4 +-
 drivers/scsi/pmcraid.c                        | 12 +++---
 drivers/scsi/ppa.c                            |  2 +-
 drivers/scsi/vmw_pvscsi.c                     |  2 +-
 drivers/scsi/wd33c93.c                        |  2 +-
 .../staging/unisys/visorhba/visorhba_main.c   |  9 ++--
 drivers/usb/image/microtek.c                  | 20 ++++-----
 drivers/usb/image/microtek.h                  |  2 +-
 16 files changed, 85 insertions(+), 86 deletions(-)

-- 
2.20.1

