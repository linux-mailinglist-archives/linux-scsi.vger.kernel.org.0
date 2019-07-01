Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0400655486
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 18:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfFYQam (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 12:30:42 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35329 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfFYQal (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 12:30:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id w20so20401733edd.2
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 09:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=kR0WUI8Wb/oooTRRXaBppmKY4itrnwNoAnfaDYxWCXg=;
        b=Ef0Cu/REsmQg6MhTc0LYNFTuhGc/eYuhkoJy1MGD6n5TmP+cKrBx8wz8DHzN4qWA/w
         vZojz0AdcMfxpwZJ7hgKiQr/hzQhMIThIwtXks+4SynHn8cJdogvib5h19034NVKrMAI
         NjWd6xGzFc6MXM3hEvtByGou96H6k5pVi1RhgmUhXkvtUZTn8bireeiH0H5rmKaFfm32
         I/VKCt/kPCSqGu1d2+flXrxMsqpEUghbeMhl4KnWUHVtkf6ud8zMVi9wgsEEysTlyCjC
         jFfLAlDGpF7w1EyEsVC3njvZ7t9cUm8tcMvbOeiJOsDj8kUUmzeT+QI4FDBlt4BZ3PQZ
         8iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=kR0WUI8Wb/oooTRRXaBppmKY4itrnwNoAnfaDYxWCXg=;
        b=CjOnpjbf5c0xifMnVH6H1DJ1E1sNyAJ6hUb0j8G//eDLqF6s3gmvrieNccxZbouP6X
         T5nELwoW1ssRIzoYPmFlGYD55mmP3BpAVxO+/KLgA3VDNA0a6jqQRbWHUjaBXVy8+0hf
         NrN3BhpJ1ACUG1/8I1whTmiUwqVRdEpgUtBZOYtgjh80AsN+koo8idVNmxJW16VkQwxD
         Bm6jetJ4e9fzEDBZgScWF5RUn3vP6DX5Wl72IG3S50w5wYop1J/GZ1EaA9cqLY6SugcQ
         OqJmZmYsnzcacQfFxYn65Z0bsq/qHKdrF1c522APuFdsRXasZKZiBExYf4dPMjlE1k+8
         T1oQ==
X-Gm-Message-State: APjAAAUFllRKLsapwxlnt6NCTwrj/i1SSNwCeFhqzz3N19ADDmH6EJxL
        zoUwqDgccYpN400J6jPTXXU6Sg==
X-Google-Smtp-Source: APXvYqyj3S0faUmz2N4ooIsNesYDYB3kQPdxuPc/QEDIXsVTGkCor1MNCYdGo1SZ2+JpaeL+DTMdng==
X-Received: by 2002:a17:906:487:: with SMTP id f7mr15597256eja.236.1561480239429;
        Tue, 25 Jun 2019 09:30:39 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id f3sm2477238ejo.90.2019.06.25.09.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 09:30:38 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <798FDD1F-415C-43CD-AC8E-3BEB08FD3AE4@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_05ED6925-114F-4BB9-8D0F-85B181FB037A";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/4] block: add zone open, close and finish support
Date:   Tue, 25 Jun 2019 18:30:37 +0200
In-Reply-To: <79ca395d-8019-9ec8-0c0b-194ca6d9eda0@acm.org>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
References: <20190621130711.21986-1-mb@lightnvm.io>
 <20190621130711.21986-2-mb@lightnvm.io>
 <ee5764fb-473a-f118-eaac-95478d885f6f@acm.org>
 <BYAPR04MB5749CEFBB45EA34BD3345CD686E00@BYAPR04MB5749.namprd04.prod.outlook.com>
 <cce08df0-0b4d-833d-64ce-f9b81f7ad7ca@lightnvm.io>
 <79ca395d-8019-9ec8-0c0b-194ca6d9eda0@acm.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


--Apple-Mail=_05ED6925-114F-4BB9-8D0F-85B181FB037A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 25 Jun 2019, at 17.55, Bart Van Assche <bvanassche@acm.org> wrote:
>=20
> On 6/25/19 3:35 AM, Matias Bj=C3=B8rling wrote:
>> On 6/25/19 12:27 AM, Chaitanya Kulkarni wrote:
>>> On 6/24/19 12:43 PM, Bart Van Assche wrote:
>>>> static inline bool op_is_write(unsigned int op)
>>>> {
>>>>     return (op & 1);
>>>> }
>> The zone mgmt commands are neither write nor reads commands. I guess, =
one could characterize them as write commands, but they don't write any =
data, they update a state of a zone on a drive. One should keep it as =
is? and make sure the zone mgmt commands don't get categorized as either =
read/write.
>=20
> Since the open, close and finish operations support modifying zone =
data I propose to characterize these as write commands. How about the =
following additional changes:
> - Make bio_check_ro() refuse open/close/flush/reset zone operations =
for read-only partitions (see also commit a32e236eb93e ("Partially =
revert "block: fail op_is_write() requests to read-only partitions"") # =
v4.18).
> - In submit_bio(), change op_is_write(bio_op(bio)) ? "WRITE" : "READ" =
into something that uses blk_op_str().
> - Add open/close/flush zone support be added in blk_partition_remap().
>=20
> Thanks,
>=20
> Bart.

Agreed. This is also what we do with REQ_OP_DISCARD and it makes things
easier in the driver.

Apart from the return comment from Damien and Minwoo, the patch looks =
good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_05ED6925-114F-4BB9-8D0F-85B181FB037A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAl0STC0ACgkQPEYBfS0l
eODeeg/8CeCql8ROfdygJuY5YBknnNtJ3MBG0pVnbVyzvejjnzJUDMmAPd6dkXe+
CqFiJ2qBtgcqQawrGwUpwG+Z3a2lq0ts9KjDEh3XWDbERplM1i9kq89xAO8E8pLU
J0zyzYyLMzp3v2Ht+UKhH37Ml2CcfUX5+fpwcF7GhNiVi03Z+g/MhA7uyZ3p52lC
9tFNmpPGHP818kqFZIZu+TrfCDQFeiUu6F+ve8X3BowxS9dzwbiTYteBKny1cBZ5
1whAbzLbStIbcKZs7An6/DCDebppZkC7HAf7ZJw4yobWOqUF2sTO3+UouYpuHNob
WPpX1+bh84AyLGVp04c2G6iNBEYfDQMRovCJ8BMOTebmRuDk7OQmldNMbGDgLhGd
ap/hGkASIUe43bFY1kVeVwAKIms8zUMBAJxHuhhQ1DErRLBEHBVtYTqQlHhX3b/L
Z3Tcldt3h+tMBjiDSh1yZ6ZREIJ0aWU6V4uTFSZjpxD7p2NA8p/2zmS3tNjAiZZ4
Ng0ENcfOPtmunqXKw1sUk7Zc5LWD8ybX3EKfU2iLfN/+N2DFl+q5w5WhKQOmBscb
DdWJglfESr6FnesiiuR3a2fhm24LlhEmNmAcE9cu6UHFcWsoIef18q+1OOdQZp5h
UGgljTYKj1Esl9iHL6/F/MPFIcpKbyFexxhY8EFlXfUO3/Amgrg=
=xyg2
-----END PGP SIGNATURE-----

--Apple-Mail=_05ED6925-114F-4BB9-8D0F-85B181FB037A--
