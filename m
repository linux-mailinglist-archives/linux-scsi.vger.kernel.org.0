Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A832E1350A9
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Jan 2020 01:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgAIAwE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 8 Jan 2020 19:52:04 -0500
Received: from ale.deltatee.com ([207.54.116.67]:53500 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgAIAwE (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 8 Jan 2020 19:52:04 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ipM2z-0004er-Vz; Wed, 08 Jan 2020 17:51:38 -0700
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "hare@suse.de" <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Stephen Bates <sbates@raithlin.com>,
        "msnitzer@redhat.com" <msnitzer@redhat.com>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        "rwheeler@redhat.com" <rwheeler@redhat.com>,
        "frederick.knight@netapp.com" <frederick.knight@netapp.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        "stephen@eideticom.com" <stephen@eideticom.com>
References: <BYAPR04MB5749820C322B40C7DBBBCA02863F0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <20200108101759.32gkjxakxigolail@mpHalley.local>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7b3cc17c-6a34-56b9-8353-f86a4015669d@deltatee.com>
Date:   Wed, 8 Jan 2020 17:51:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200108101759.32gkjxakxigolail@mpHalley.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: stephen@eideticom.com, joshi.k@samsung.com, Matias.Bjorling@wdc.com, frederick.knight@netapp.com, rwheeler@redhat.com, roland@purestorage.com, zach.brown@ni.com, mpatocka@redhat.com, msnitzer@redhat.com, sbates@raithlin.com, hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com, hare@suse.de, bvanassche@acm.org, axboe@kernel.dk, lsf-pc@lists.linux-foundation.org, dm-devel@redhat.com, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, linux-block@vger.kernel.org, Chaitanya.Kulkarni@wdc.com, javier@javigon.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 2020-01-08 3:17 a.m., Javier González wrote:
> I think this is good topic and I would like to participate in the
> discussion too. I think that Logan Gunthorpe would also be interested
> (Cc). Adding Kanchan too, who is also working on this and can contribute
> to the discussion
> 
> We discussed this in the context of P2P at different SNIA events in the
> context of computational offloads and also as the backend implementation
> for Simple Copy, which is coming in NVMe. Discussing this (again) at
> LSF/MM and finding a way to finally get XCOPY merged would be great.

Yes, I would definitely be interested in discussing copy offload
especially in the context of P2P. Sorting out a userspace interface for
this that supports a P2P use case would be very beneficial to a lot of
folks.

Thanks,

Logan
