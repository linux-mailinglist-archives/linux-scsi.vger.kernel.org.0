Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7925F260CBA
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Sep 2020 09:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgIHH6c (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Sep 2020 03:58:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:54036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbgIHH54 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 8 Sep 2020 03:57:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 41CD8B6CD;
        Tue,  8 Sep 2020 07:57:55 +0000 (UTC)
Date:   Tue, 8 Sep 2020 09:57:53 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Arun Easi <aeasi@marvell.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nilesh Javali <njavali@marvell.com>,
        Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH v2 4/4] qla2xxx: Handle incorrect entry_type entries
Message-ID: <20200908075753.ov64u2rmhet3jmlu@beryllium.lan>
References: <20200831161854.70879-1-dwagner@suse.de>
 <20200831161854.70879-5-dwagner@suse.de>
 <alpine.LRH.2.21.9999.2009072346360.28578@irv1user01.caveonetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.9999.2009072346360.28578@irv1user01.caveonetworks.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Arun,

On Mon, Sep 07, 2020 at 11:47:48PM -0700, Arun Easi wrote:
> Could you drop the above comment about firmware, as it is speculation at
> this point?

Sure, no problem.

> It'd be best to take a chip reset path, rather than assuming the
> packet is good and having the appropriate handler called (hacky).
> An approach similar to the one done at the beginning of
> qla2x00_get_sp_from_handle() is what I had in mind.

Ok, agreed a reset is probably the safest choice.

> I'd have preferred a common approach across the different IOCB types
> as an attempt to harden the code, but that will be a little more
> involved work. This looks ok.

Yes, I was pondering on it but I don't know enough to really come up
with something reasonable. Currently our customers report only this
hickup. So this is really only a partial workaround.

Thanks,
Daniel
