Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679693EA4AF
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Aug 2021 14:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbhHLM2p (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 Aug 2021 08:28:45 -0400
Received: from verein.lst.de ([213.95.11.211]:44176 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237469AbhHLM2p (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 12 Aug 2021 08:28:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9D0FC68B05; Thu, 12 Aug 2021 14:28:18 +0200 (CEST)
Date:   Thu, 12 Aug 2021 14:28:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v5 01/52] core: Introduce the scsi_cmd_to_rq() function
Message-ID: <20210812122818.GD19050@lst.de>
References: <20210809230355.8186-1-bvanassche@acm.org> <20210809230355.8186-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809230355.8186-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This seems to miss a cover letter and about 40 or your 52 patches.  No
idea how I am supposed to review it.
