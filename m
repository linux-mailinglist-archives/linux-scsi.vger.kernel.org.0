Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF923BD02
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jun 2019 21:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389228AbfFJTkA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jun 2019 15:40:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388843AbfFJTkA (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Jun 2019 15:40:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C173988305;
        Mon, 10 Jun 2019 19:39:53 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24A115C1B4;
        Mon, 10 Jun 2019 19:39:48 +0000 (UTC)
Message-ID: <493f280a5d02cdd568064309c67da2ad20df5ab6.camel@redhat.com>
Subject: Re: [PATCH 1/5] scsi: vmw_pscsi: use sgl helper to operate sgl
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>
Date:   Mon, 10 Jun 2019 15:39:47 -0400
In-Reply-To: <1560192046.3698.11.camel@HansenPartnership.com>
References: <20190610150317.29546-1-ming.lei@redhat.com>
         <20190610150317.29546-2-ming.lei@redhat.com>
         <1560192046.3698.11.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 10 Jun 2019 19:40:00 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 2019-06-10 at 11:40 -0700, James Bottomley wrote:
> On Mon, 2019-06-10 at 23:03 +0800, Ming Lei wrote:
> > The current way isn't safe for chained sgl, so use sgl helper to
> > operate sgl.
> 
> This also isn't a chained driver.  However, this driver seems to
> achieve this by magic number matching, which looks unsafe.  I'd really
> prefer it if vmw_pvscsi.h had
> 
> #define PVSCSI_MAX_NUM_SG_ENTRIES_PER_SEGMENT SG_ALL
> 
> James
> 

vmw_pvscsi appears to be definitely broken though, that's how Ming found these...

-Ewan
