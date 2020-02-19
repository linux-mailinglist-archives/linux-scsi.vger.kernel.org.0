Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB62D163AAA
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Feb 2020 04:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgBSDCj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Feb 2020 22:02:39 -0500
Received: from sonic317-27.consmr.mail.bf2.yahoo.com ([74.6.129.82]:37383 "EHLO
        sonic317-27.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728196AbgBSDCi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 18 Feb 2020 22:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582081356; bh=EoSOra7a2saN4Rx9MPg7CnNKAW+5S8RlMnV+0g1PH1E=; h=Date:From:Reply-To:Subject:References:From:Subject; b=BiX8ahnRmPK8cadSBG4tyrkSqwjZIfiWj1w4JR/hsmkTKps+9OmJSjrH/V0LY+iE3fxfbk2VOpYJM6FejXAPGTsX2M9ARxC4ZiGXdiIw9bjXK23iHmj3Kng8KNa+31FeDQl16AxyzmPEKiLCpyU6XxfBVCnfTl3OAh/k411DaI6V6NiBNvHnCnvSYwDbjDfyXy7ZRpzh3d6s1coUERcq0cXNe5zLpv8gAlwuMg3Y6e5JDoQfvV3OQ7iEEd3VGTkmdvh6sTZg9QBvNEAzYQH5ifnEY4iShw8WyCNNSPe/VkuEqVeVkjGQW6nhUuhwgSJJzyBGRIWjMqgIgpWQEe4EUA==
X-YMail-OSG: ZvaGY5UVM1kc0cLLk9X6svFfqeg_QIRz2JZUFUmz1NE5kW5BQhe6mdBmuW427V2
 HQkkLBbwVl.egNdkkruWa9pAlNmrxUV1G210kH0QwbQDdz22G.lCJavXFq7zxonLlCZDc60JOj3G
 enT68L8bhEIo.KBufvmIzreSIt6O5kB1le_MnhlA1XkWy_sLg7N55eJWTrXlKlLp0yrc5z8k9k60
 TySS2_h2FqOzXDu_IBOe6ux2_zNZQ0yv_P943GgcImXe4vVq3MGOWqklvFzS.bJLlPyLvM_q5jrx
 LA35s_DgR1NfReVySVqD9q.yDiz0vhtzFbnJwtVTPqVq3Grqhyooe.atlNB4yd223MCCPPMBSGNC
 eQY0waG5L3ASs38qSBE6_hc7MkujbMHP1BjHQNAsKuDIswOBPYaBhZo3yfrEdBvBUHbZylJo4sgx
 4CF1JQPubQwG11CPx37ZDcqLl9v2H_0qQAlGHs3IGVetCRoXmm7eVz11Tup8EWco6DVx6_IQRiwj
 KTEzQqRkQwBdX2S7.ge575iOwdn8Ol0WxD.LgIMP6eOPNLAIAfdoWhY4QFgmqthetMul6njnm5yb
 ZZCMs3ZOtBzLnmgwWQ3LVjilUm7HLiirqyMaSm1iT6MZr84MNhmXJhj97JVUBIEXGqx1f.8LPvVw
 JY6WBCZB9mIdSVNwGfhyUYUdTMsjDyKRrdnyiv1L617D6jeYuSLbfszuEME1XxSoi7LfhnB3BhfS
 Mvx1sP.OXGB6EAXuw9jWuMn82dW26D0VDEqA0R4T5jWFKfsgwZFIpXyD.MX9Ru3RvY2aC4y2Q98u
 XNnEjv8Il7Elh_iLpl7f7e6YvgL2W1.QSsuzJcGoiQH3q7ADaQE0gEZx24tmL0HPfUOC0UxWKs1w
 _kfiu.hRE6.sSxF_pDUpuMobIoLEi1WGUCx.L0MhB.hUn6A8YAklsuG6cwj_cfaNK09IWkmHKgrC
 2F2wYtCfI8MhYYHxr7V6xwHYcrSGq8KwRBpo_uFd8teWG45rRVJVTQQoXPD1Bm5Kp_uJTxUnsCrj
 .UG.hE4.o50IQNTMVpbNtSOWH0nKpmncvRPJOFjhFkmpjeX5N_JQQLfrqR6vrDD9aO3i0z15W.gh
 2BS6ukDs05IXJM1V1ntQk4PR3arsVbM2vHntJRCgP3.O45u3k2o4l1hyZeXb65zw50byv19F8r_5
 zK92Fd2xQpETQaPUXTby0Fw72k.YEotyG8w.IIN2ESSX8wG65UQ5bns2PgQ3Gb4URE0Haec7HR4w
 qVkjh40nl405oAtwSWuAN82O8NvYmR_fqG2YbSTKJFPXR9sqUpW92Z.OYl2u.NgqZur0C0ClbKgi
 0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Wed, 19 Feb 2020 03:02:36 +0000
Date:   Wed, 19 Feb 2020 03:02:32 +0000 (UTC)
From:   Mohaiyani Binti <mohaiyanibintis100@gmail.com>
Reply-To: mohaiyanibintis100@gmail.com
Message-ID: <1132317950.3564766.1582081352266@mail.yahoo.com>
Subject: Dear Sir or Madam
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1132317950.3564766.1582081352266.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15199 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:73.0) Gecko/20100101 Firefox/73.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Dear Sir or Madam

I am Mohaiyani binti Shamsudin, who works in ADB (BURKINA FASO) as a non-independent non-executive Director and President of AFRICAN DEVELOPMENT BANK.
During our last banking audits, we discovered that an account abandoned belongs to one of our deceased foreign clients, the Mr. Wang Jian, co-founder and co-chair of the HNA Group, a conglomerate Chinese with important real estate properties throughout the US UU. in a accident during a business trip in France on Tuesday.

Go to this link: https://observer.com/2018/07/wang-jian-hna-founder-dies-tragic-fall/

I am writing to request your assistance to transfer the sum of $ 15,000,000.00 (fifteen million United States dollars) at its counts as Wang Jian's last foreign business partner, which I plan use the fund to invest in public benefit as follows

1. Establish an orphanage home to help orphaned children.
2. Build a hospital to help the poor.
3. Build an asylum for the elderly and homeless.

Meanwhile, before contacting you, I did an investigation staff to locate one of the relatives of the late Mr. Wang Jian who knows the account, but I didn't succeed. However, I took this decision to support orphans and less privileged children with this fund, because I don't want this fund transferred to our Account of Government treasury as unclaimed fund. I am willing to offer you the 40% of the fund for your support and assistant to transfer the fund to your account.

More detailed information will be sent to the disaggregation explaining how The fund will be transferred to you. Please continue to achieve the purpose.

Waiting for your urgent response.
Attentively
Mohaiyani Binti Shamsudin.
