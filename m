Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0093B7F3
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jun 2019 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389322AbfFJPDn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jun 2019 11:03:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbfFJPDm (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Jun 2019 11:03:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F3CE2F8BDF;
        Mon, 10 Jun 2019 15:03:34 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5E5860A35;
        Mon, 10 Jun 2019 15:03:24 +0000 (UTC)
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
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/5] scsi: use sg helper to operate sgl
Date:   Mon, 10 Jun 2019 23:03:12 +0800
Message-Id: <20190610150317.29546-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 10 Jun 2019 15:03:34 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

Most of drivers uses sg helper to operate sgl, however there is
still a few drivers which operates sgl directly, this way can't
work in case of chained sgl.

So convert them to use sg helper to operate sgl.


Ming Lei (5):
  scsi: vmw_pscsi: use sgl helper to operate sgl
  scsi: advansys: use sg helper to operate sgl
  scsi: ipr: use sg helper to operate sgl
  scsi: lpfc:  use sg helper to operate sgl
  scsi: mvumi: use sg helper to operate sgl

 drivers/scsi/advansys.c        | 2 +-
 drivers/scsi/ipr.c             | 7 ++++---
 drivers/scsi/lpfc/lpfc_nvmet.c | 3 +--
 drivers/scsi/mvumi.c           | 9 ++++-----
 drivers/scsi/vmw_pvscsi.c      | 2 +-
 5 files changed, 11 insertions(+), 12 deletions(-)

-- 
2.20.1

