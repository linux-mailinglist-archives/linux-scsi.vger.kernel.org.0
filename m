Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B43410324D
	for <lists+linux-scsi@lfdr.de>; Wed, 20 Nov 2019 04:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKTDrx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 19 Nov 2019 22:47:53 -0500
Received: from gate.crashing.org ([63.228.1.57]:56324 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbfKTDrx (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 19 Nov 2019 22:47:53 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id xAK3kwKl021554;
        Tue, 19 Nov 2019 21:46:59 -0600
Message-ID: <e28308b25c4f2abc6e5ce862ecfc1e44323d9448.camel@kernel.crashing.org>
Subject: Re: [PATCH] lpfc: fixup out-of-bounds access during CPU hotplug
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Daniel Wagner <daniel.wagner@suse.com>,
        linux-scsi@vger.kernel.org
Date:   Wed, 20 Nov 2019 14:46:58 +1100
In-Reply-To: <bf84585e-76e6-1a87-8b72-090b5063b981@broadcom.com>
References: <20191118123012.99664-1-hare@suse.de>
         <5c61c1ce-d4fc-23b8-621a-897febb89b67@broadcom.com>
         <1713444f-2788-ca07-3452-efc9457215d9@suse.de>
         <1dca4247-5d02-5232-cd73-a5519f1bbb94@broadcom.com>
         <bf84585e-76e6-1a87-8b72-090b5063b981@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 2019-11-19 at 09:34 -0800, James Smart wrote:
> Although... num_possible_cpus() shouldn't change, but I guess a cpu
> id 
> can be greater than the possible cpu count.
> 
> But there is this as well - also from include/linux/cpumask.h:
>   *  If HOTPLUG is enabled, then cpu_possible_mask is forced to have
>   *  all NR_CPUS bits set, otherwise it is just the set of CPUs that
>   *  ACPI reports present at boot.

That's probably an x86'ism... on powerpc the mask is set based on
what's really possible and it may not be all bits

Cheers,
Ben.


