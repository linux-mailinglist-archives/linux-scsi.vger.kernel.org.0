Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B998C100853
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Nov 2019 16:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKRPgY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 18 Nov 2019 10:36:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:42788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726748AbfKRPgY (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 18 Nov 2019 10:36:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2752CAD33;
        Mon, 18 Nov 2019 15:36:23 +0000 (UTC)
Date:   Mon, 18 Nov 2019 16:36:22 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Daniel Wagner <daniel.wagner@suse.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] lpfc: fixup out-of-bounds access during CPU hotplug
Message-ID: <20191118153622.xsaqawn2hij6ff4b@beryllium.lan>
References: <20191118123012.99664-1-hare@suse.de>
 <20191118142259.nszyqku5pewuu6st@beryllium.lan>
 <54fb3ce0-b9a9-cd8b-8459-452e26b157af@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54fb3ce0-b9a9-cd8b-8459-452e26b157af@suse.de>
User-Agent: NeoMutt/20180716
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

> phba->sli4_hba.cpu_map = kcalloc(phba->sli4_hba.num_possible_cpu,
> 				sizeof(struct lpfc_vector_map_info),
> 				GFP_KERNEL);
> 

Indeed, I didn't realize this.

Thanks,
Daniel
