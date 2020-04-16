Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2191AC1AF
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Apr 2020 14:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636221AbgDPMqi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 Apr 2020 08:46:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:55674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636192AbgDPMpH (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 16 Apr 2020 08:45:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 09B42ABAD;
        Thu, 16 Apr 2020 12:45:06 +0000 (UTC)
Date:   Thu, 16 Apr 2020 14:45:05 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org,
        maier@linux.ibm.com, bvanassche@acm.org, herbszt@gmx.de,
        natechancellor@gmail.com, rdunlap@infradead.org,
        Ram Vegesna <ram.vegesna@broadcom.com>
Subject: Re: [PATCH v3 25/31] elx: efct: Hardware IO submission routines
Message-ID: <20200416124505.cqqkotnsjhlpkhp3@carbon>
References: <20200412033303.29574-1-jsmart2021@gmail.com>
 <20200412033303.29574-26-jsmart2021@gmail.com>
 <1af2f44d-ede4-bdd8-5812-9d4526a1f9b5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1af2f44d-ede4-bdd8-5812-9d4526a1f9b5@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Apr 16, 2020 at 10:10:18AM +0200, Hannes Reinecke wrote:
> > +	switch (type) {
> > +	case EFCT_HW_ELS_REQ:
> > +		if (!send ||
> > +		    sli_els_request64_wqe(&hw->sli, io->wqe.wqebuf,
> > +					  hw->sli.wqe_size, io->sgl,
> > +					*((u8 *)send->virt),
> > +					len, receive->size,
> > +					iparam->els.timeout,
> > +					io->indicator, io->reqtag,
> > +					SLI4_CQ_DEFAULT, rnode->indicator,
> > +					rnode->sport->indicator,
> > +					rnode->attached, rnode->fc_id,
> > +					rnode->sport->fc_id)) {
> > +			efc_log_err(hw->os, "REQ WQE error\n");
> > +			rc = EFCT_HW_RTN_ERROR;
> > +		}
> > +		break;
> 
> I did mention several times that I'm not a big fan of overly long argument
> lists.
> Can't you pass in 'io' and 'rnode' directly and cut down on the number of
> arguments?

Yes, please!
