Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9402372865
	for <lists+linux-scsi@lfdr.de>; Tue,  4 May 2021 12:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhEDKCB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 May 2021 06:02:01 -0400
Received: from verein.lst.de ([213.95.11.211]:38810 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230092AbhEDKBZ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 May 2021 06:01:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2FC2B68BEB; Tue,  4 May 2021 11:59:58 +0200 (CEST)
Date:   Tue, 4 May 2021 11:59:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 09/18] snic: use tagset iter for traversing commands
Message-ID: <20210504095957.GF25986@lst.de>
References: <20210503150333.130310-1-hare@suse.de> <20210503150333.130310-10-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503150333.130310-10-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Same questions as for fnic: why does the driver implements its own
command completion in the EH path?
