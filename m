Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9441C10787
	for <lists+linux-scsi@lfdr.de>; Wed,  1 May 2019 13:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEALmF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 May 2019 07:42:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:57510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbfEALmF (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 1 May 2019 07:42:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3CB8DAEF7;
        Wed,  1 May 2019 11:42:04 +0000 (UTC)
Date:   Wed, 1 May 2019 07:42:00 -0400
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     kbuild test robot <lkp@intel.com>
Cc:     Ondrej Zary <linux@zary.sk>, kbuild-all@01.org,
        linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [scsi:misc 301/301] drivers/scsi/fdomain.c:442:12: sparse:
 sparse: context imbalance in 'fdomain_host_reset' - wrong count at exit
Message-ID: <20190501114200.GA25931@linux-x5ow.site>
References: <201904301607.g1dqOnQ8%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201904301607.g1dqOnQ8%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Apr 30, 2019 at 04:02:15PM +0800, kbuild test robot wrote:
[...]
> >> drivers/scsi/fdomain.c:442:12: sparse: sparse: context imbalance in 'fdomain_host_reset' - wrong count at exit
> 
> vim +/fdomain_host_reset +442 drivers/scsi/fdomain.c
> 
> 92408047 Ondrej Zary 2019-04-29  441  
> 92408047 Ondrej Zary 2019-04-29 @442  static int fdomain_host_reset(struct scsi_cmnd *cmd)
> 92408047 Ondrej Zary 2019-04-29  443  {
> 92408047 Ondrej Zary 2019-04-29  444  	struct Scsi_Host *sh = cmd->device->host;
> 92408047 Ondrej Zary 2019-04-29  445  	struct fdomain *fd = shost_priv(sh);
> 92408047 Ondrej Zary 2019-04-29  446  	unsigned long flags;
> 92408047 Ondrej Zary 2019-04-29  447  
> 92408047 Ondrej Zary 2019-04-29  448  	spin_lock_irqsave(sh->host_lock, flags);
> 92408047 Ondrej Zary 2019-04-29  449  	fdomain_reset(fd->base);
> 92408047 Ondrej Zary 2019-04-29  450  	spin_lock_irqsave(sh->host_lock, flags);

That should be a spin_unlock_irqrestore() here	~^
Otherwise this would end badly.

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
