Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C926D43CED
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Jun 2019 17:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfFMPib (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jun 2019 11:38:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731957AbfFMKEg (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Jun 2019 06:04:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D3FA307D869;
        Thu, 13 Jun 2019 10:04:33 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A3F77C0B4;
        Thu, 13 Jun 2019 10:04:15 +0000 (UTC)
Date:   Thu, 13 Jun 2019 18:04:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        devel@driverdev.osuosl.org, Hannes Reinecke <hare@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        James Smart <james.smart@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>, Jim Gill <jgill@vmware.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Brian King <brking@us.ibm.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        "Juergen E . Fischer" <fischer@norbit.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 08/15] staging: unisys: visorhba: use sg helper to
 operate sgl
Message-ID: <20190613100410.GA10829@ming.t460p>
References: <20190613071335.5679-1-ming.lei@redhat.com>
 <20190613071335.5679-9-ming.lei@redhat.com>
 <20190613095214.GA18796@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613095214.GA18796@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 13 Jun 2019 10:04:36 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Jun 13, 2019 at 11:52:14AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jun 13, 2019 at 03:13:28PM +0800, Ming Lei wrote:
> > The current way isn't safe for chained sgl, so use sg helper to
> > operate sgl.
> 
> I can not make any sense out of this changelog.
> 
> What "isn't safe"?  What is a "sgl"?

sgl is 'scatterlist' in kernel, and several linear sgl can be chained
together, so accessing the sgl in linear way may see a chained sg, which
is like a link pointer, then may cause trouble for driver.

> 
> Can this be applied "out of order"?

Yes, there isn't any dependency among the 15 patches.


Thanks,
Ming
