Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA3ED6FEE8
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jul 2019 13:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfGVLnU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Jul 2019 07:43:20 -0400
Received: from verein.lst.de ([213.95.11.211]:59765 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728934AbfGVLnU (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 22 Jul 2019 07:43:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4DC8B68B20; Mon, 22 Jul 2019 13:43:19 +0200 (CEST)
Date:   Mon, 22 Jul 2019 13:43:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 1/3] libfc: Whitespqce cleanup in libfc.h
Message-ID: <20190722114319.GB32052@lst.de>
References: <20190722062231.115865-1-hare@suse.de> <20190722062231.115865-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722062231.115865-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
