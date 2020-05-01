Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3F41C1C33
	for <lists+linux-scsi@lfdr.de>; Fri,  1 May 2020 19:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgEARqt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 May 2020 13:46:49 -0400
Received: from verein.lst.de ([213.95.11.211]:48094 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729713AbgEARqt (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 1 May 2020 13:46:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B27A868D12; Fri,  1 May 2020 19:46:47 +0200 (CEST)
Date:   Fri, 1 May 2020 19:46:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC v3 00/41] scsi: enable reserved commands for LLDDs
Message-ID: <20200501174647.GD23795@lst.de>
References: <20200430131904.5847-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430131904.5847-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Can we get the basic infrastructure sorted out with just say csiostor
and virtio-scsi before we get into all the more complicated bits?
A 40+ series gets close to impossible to review unless it is just
all mechnical changes.
