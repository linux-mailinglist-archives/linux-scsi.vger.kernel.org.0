Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E983330B82
	for <lists+linux-scsi@lfdr.de>; Mon,  8 Mar 2021 11:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhCHKnY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 8 Mar 2021 05:43:24 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:61838 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhCHKm4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 8 Mar 2021 05:42:56 -0500
Date:   Mon, 08 Mar 2021 10:42:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1615200172;
        bh=I86ECOcVLds18ZH/fRq59iRJTsF+ysSoc+v6gqv+DEI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=IUM+fMZK+c1HFoVIS3UUh7BEm7OVXhcWjbqEAfLrMQE6bL61ZqMwgi5yQwaPnYf39
         z+JtXNfjWCNI9yiKWuTNzkyiWJxqOPOYHlADABnl7bALNFLD0wY4RW+j1SaFabeQQZ
         ssfcznsS4MNiVxroldVGMUlXPUBqiplSYRvgBG8w=
To:     Christoph Hellwig <hch@lst.de>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        ejb@linux.ibm.com, stanley.chu@mediatek.com, cang@codeaurora.org,
        beanhuo@micron.com, jaegeuk@kernel.org, asutoshd@codeaurora.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH 1/3] scsi: ufshcd: switch to a version macro
Message-ID: <0c6cff2b-8d56-2b34-837d-b3d8f1fa5ad9@connolly.tech>
In-Reply-To: <20210308080013.GE983@lst.de>
References: <20210308005739.1998483-1-caleb@connolly.tech> <20210308005739.1998483-2-caleb@connolly.tech> <20210308080013.GE983@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Christoph,

On 08/03/2021 8:00 am, Christoph Hellwig wrote:
> This looks like a really nice improvement!
>
> A bunch of comments below:
>
>> @@ -696,10 +685,21 @@ static inline u32 ufshcd_get_intr_mask(struct ufs_=
hba *hba)
>>    */
>>   static inline u32 ufshcd_get_ufs_version(struct ufs_hba *hba)
>>   {
>> +=09u32 ufshci_ver;
> missing eempty line after the declaration.
>
>>   =09if (hba->quirks & UFSHCD_QUIRK_BROKEN_UFS_HCI_VERSION)
>> +=09=09ufshci_ver =3D ufshcd_vops_get_ufs_hci_version(hba);
>> +=09else
>> +=09=09ufshci_ver =3D ufshcd_readl(hba, REG_UFS_VERSION);
>>
>> +=09/*
>> +=09 * UFSHCI v1.x uses a different version scheme, in order
>> +=09 * to allow the use of comparisons with the UFSHCI_VER
>> +=09 * macro, we convert it to the same scheme as ufs 2.0+.
>> +=09 */
>> +=09if (ufshci_ver & 0x00010000)
>> +=09=09ufshci_ver =3D UFSHCI_VER(1, ufshci_ver & 0x00000100);
>> +
>> +=09return ufshci_ver;
> I'd use early returns here to clean this up a bit:
>
>   =09if (hba->quirks & UFSHCD_QUIRK_BROKEN_UFS_HCI_VERSION)
> =09=09ufshci_ver =3D ufshcd_vops_get_ufs_hci_version(hba);
>
> =09...
> =09ufshci_ver =3D ufshcd_readl(hba, REG_UFS_VERSION);
> =09if (ufshci_ver & 0x00010000)
> =09=09return UFSHCI_VER(1, ufshci_ver & 0x00000100);
> =09return ufshci_ver;
>
>> +#define UFSHCI_VER(major, minor) \
>> +=09((major << 8) + (minor << 4))
> This needs braces around major and minor.  Or better just convert it
> to an inline function (and use a lower case name).

Other (similar) implementations, like NVME_VS() use a macro here, is an=20
inline function just personal preference?

I'm perfectly happy either way, so I'll switch to your suggestion.

Thanks for the review.

Regards,

Caleb



