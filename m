Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BAC1D9B1D
	for <lists+linux-scsi@lfdr.de>; Tue, 19 May 2020 17:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgESP16 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 19 May 2020 11:27:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:43986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbgESP16 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 19 May 2020 11:27:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DC695B26A;
        Tue, 19 May 2020 15:27:59 +0000 (UTC)
Date:   Tue, 19 May 2020 17:27:56 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Arun Easi <aeasi@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        Quinn Tran <qutran@marvell.com>,
        Martin Wilck <mwilck@suse.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH v6 15/15] qla2xxx: Fix endianness annotations in source
 files
Message-ID: <20200519152756.swpazvzbtrrrzsgc@beryllium.lan>
References: <20200514213516.25461-1-bvanassche@acm.org>
 <20200514213516.25461-16-bvanassche@acm.org>
 <20200515094401.lvdsr7q4m7j26ze6@beryllium.lan>
 <4dbf62ef-b7ce-f602-629a-c422cc89005d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dbf62ef-b7ce-f602-629a-c422cc89005d@acm.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Bart,

On Mon, May 18, 2020 at 02:13:53PM -0700, Bart Van Assche wrote:
> On 2020-05-15 02:44, Daniel Wagner wrote:
> > I try to give the whole series a spin on our system next week.
> 
> That would be welcome. v7 of this patch series is available at
> https://github.com/bvanassche/linux/tree/qla2xxx-for-next.

I gave this a spin on one of our machines with a QLE2742. Seems to
work fine and there was not obvious problem.

Thanks,
Daniel
