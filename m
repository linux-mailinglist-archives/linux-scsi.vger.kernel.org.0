Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8143F39C30
	for <lists+linux-scsi@lfdr.de>; Sat,  8 Jun 2019 11:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfFHJgT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 8 Jun 2019 05:36:19 -0400
Received: from verein.lst.de ([213.95.11.211]:60839 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfFHJgS (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 8 Jun 2019 05:36:18 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4DA45227A82; Sat,  8 Jun 2019 11:35:49 +0200 (CEST)
Date:   Sat, 8 Jun 2019 11:35:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH 1/3] scsi: Do not allow user space to change the SCSI
 device state into SDEV_BLOCK
Message-ID: <20190608093548.GA20610@lst.de>
References: <20190605201435.233701-1-bvanassche@acm.org> <20190605201435.233701-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605201435.233701-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Thanks.  As discusssed before there really shouldn't be any reason
for users to inject a blocked state:

Reviewed-by: Christoph Hellwig <hch@lst.de>
