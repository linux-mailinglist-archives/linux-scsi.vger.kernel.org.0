Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397BC1B5485
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2020 08:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgDWGDB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 23 Apr 2020 02:03:01 -0400
Received: from verein.lst.de ([213.95.11.211]:56082 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgDWGDB (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 23 Apr 2020 02:03:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9CD39227A8A; Thu, 23 Apr 2020 08:02:57 +0200 (CEST)
Date:   Thu, 23 Apr 2020 08:02:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V2] scsi: put hot fields of scsi_host_template into one
 cacheline
Message-ID: <20200423060256.GA9537@lst.de>
References: <20200422095425.319674-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422095425.319674-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good, although you might want to throw in a blurb on the
actually measured benefits:

Reviewed-by: Christoph Hellwig <hch@lst.de>
