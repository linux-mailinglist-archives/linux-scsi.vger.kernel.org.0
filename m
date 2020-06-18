Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B5E1FF6B1
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2020 17:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbgFRP2z (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 Jun 2020 11:28:55 -0400
Received: from verein.lst.de ([213.95.11.211]:49661 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731495AbgFRP2v (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 18 Jun 2020 11:28:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 52D876736F; Thu, 18 Jun 2020 17:28:48 +0200 (CEST)
Date:   Thu, 18 Jun 2020 17:28:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com,
        brking@us.ibm.com, jinpu.wang@cloud.ionos.com, mpe@ellerman.id.au,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: fix ATAPI support for libsas drivers
Message-ID: <20200618152848.GA30919@lst.de>
References: <20200615064624.37317-1-hch@lst.de> <d3459f71-501e-3fea-d5dc-a5599758459d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3459f71-501e-3fea-d5dc-a5599758459d@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Jun 18, 2020 at 10:02:58AM +0100, John Garry wrote:
> On 15/06/2020 07:46, Christoph Hellwig wrote:
>> Hi all,
>>
>> this series fixes the ATAPI DMA drain refactoring for SAS HBAs that
>> use libsas.
>> .
>>
>
> Something I meant to ask before and was curious about, specifically since 
> ipr doesn't actually use libsas: Why not wire up other SAS HBAs, like 
> megaraid_sas?

megaraid_sas and mpt3sas don't use the libata code at all.  ipr actually
is a special case and uses libata directly instead of libsas (something
I hadn't realized, but which doesn't change anything for the patches
itself, just possibly the commit log).
