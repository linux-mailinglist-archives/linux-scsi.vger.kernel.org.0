Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90AB0B26BB
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Sep 2019 22:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbfIMUgI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 13 Sep 2019 16:36:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:50208 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388167AbfIMUgI (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 13 Sep 2019 16:36:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B6E6AF77;
        Fri, 13 Sep 2019 20:36:07 +0000 (UTC)
Message-ID: <bcab32ef2d17d7d14c3a5d41ee711e21ab749ab3.camel@suse.de>
Subject: Re: [PATCH 2/6] qla2xxx: Fix flash read for Qlogic ISPs
From:   Martin Wilck <mwilck@suse.de>
To:     Himanshu Madhani <hmadhani@marvell.com>,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org
Date:   Fri, 13 Sep 2019 22:36:43 +0200
In-Reply-To: <20190830222402.23688-3-hmadhani@marvell.com>
References: <20190830222402.23688-1-hmadhani@marvell.com>
         <20190830222402.23688-3-hmadhani@marvell.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 2019-08-30 at 15:23 -0700, Himanshu Madhani wrote:
> From: Quinn Tran <qutran@marvell.com>
> 
> Use adapter specific callback to read flash instead of ISP
> adapter specific.
> 
> Signed-off-by: Quinn Tran <qutran@marvell.com>
> Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
> ---
>  drivers/scsi/qla2xxx/qla_init.c | 4 ++--
>  drivers/scsi/qla2xxx/qla_nx.c   | 1 +
>  drivers/scsi/qla2xxx/qla_sup.c  | 8 ++++----
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 

Tested-by: Martin Wilck <mwilck@suse.com>

I believe this patch should be tagged with

Fixes: 5fa8774c7f38 (scsi: qla2xxx: Add 28xx flash primary/secondary status/image mechanism)

I just bisected the FW initialization problems on my 8200 series CNA to
that commit, and I can confirm that this patch fixes it.


