Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF6839C34
	for <lists+linux-scsi@lfdr.de>; Sat,  8 Jun 2019 11:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfFHJj5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 8 Jun 2019 05:39:57 -0400
Received: from verein.lst.de ([213.95.11.211]:60849 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfFHJj4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 8 Jun 2019 05:39:56 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7858D68AA6; Sat,  8 Jun 2019 11:39:29 +0200 (CEST)
Date:   Sat, 8 Jun 2019 11:39:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/3] scsi: Avoid that .queuecommand() gets called for a
 quiesced SCSI device
Message-ID: <20190608093929.GB20610@lst.de>
References: <20190605201435.233701-1-bvanassche@acm.org> <20190605201435.233701-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605201435.233701-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
