Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C891CB2C5
	for <lists+linux-scsi@lfdr.de>; Fri,  8 May 2020 17:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgEHP1b (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 8 May 2020 11:27:31 -0400
Received: from sonic305-21.consmr.mail.ne1.yahoo.com ([66.163.185.147]:46359
        "EHLO sonic305-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726689AbgEHP1b (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 8 May 2020 11:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1588951650; bh=Uv9Il0GvVfNf8ySja/n2kkVJo04KZ3nX+ejOBNQOQ/8=; h=Date:From:Reply-To:Subject:References:From:Subject; b=tVOG8QYlvOE/p0Vyi4dNQPujQ4eAZrqVui3KgAhyy2uld8XizQg/h4Xm+AwwTA2FSspTpyTUa5oQuOg9e+rp1HIgOj7/mbFuqykTyvSLvDbbXfsT6vgQ/G137FMd/BYW/z2XWyF3nVYUtAxp8bL5PSve9CweyOC6iznit6L56OBmDi6m2QxpWzA43ftt0//bedVuX56wt1PVrf6FTnGGxAbFlt27fazV3mXFuH9S2TuZR7cfWEdOtb9vB+6dE2ULQdM0DaHFmRdJj5Mv6zys7lvefegMDcswAI12UDXRtg1DzJAk3q3UYOUpykM6vA5eAJPOxLs5nq9aRv3QierTxQ==
X-YMail-OSG: LbLwM.EVM1nXcjz9oQZkfZFueAKnCgz0ze42WAWWg5AtNyOl8dQY5Vqjz_ufdJi
 1uEYXhF5skGPXSDSW5r8b3lkUVo4EcRMVUP4xTqIqS_usd2ehFzEA.ivTDnXcjHoz6uZ5vgCAv21
 PN9VwBcF.gHSwukXv2H_GOEmwlZXFO0915WhXrQvwuZXHlnS.2HsFxDXrgitf6H1LW2a4kK8L0cE
 vAMtVkr5mrWL2EQ4dJT5i.0NugBR4BIaBs3CRc.kSTBhNSEjQaCKqowf_UtHiOZPzlc9jVjavEcE
 1OZl3_QanmoZDiiSh.kPNoIpu4qoFFuEWZiW39jzDOCN4fJYV0oqpqF72poM1D07KCsIXnYLL5Ii
 L_TU9aMJYw6RzGjDmBStZqfOcpnsNqnYShPeHclDvzgYEzrgzIR2YGY7kgMnSbv7uBjNavy3chgx
 P6Eae0rXArcT5Tl_MFsIqOrlrHZYaQcXaeIzqEY.JnT6cHoGreGd83NJxj7INlwXu21.0d2M0yXH
 q17vDeFWQkmG97lo2aKL5uO8xRwldpbUt4.ReNWp0CqV9X2X4k9cpwy4so9hRzLfKC48jEY_D3tn
 xNq43hNCZUoibmXP0jS1Wt7VJSUJh4KiKrUZDiTdBV3wZBcidyrr3oKpdZSzB.y9P4B4F2eegoq9
 _0bPv1oKbrATwnazUjl.fNAFy8h51WVGroHG8A5Vm_Y9_ry2iCuadU2vlT5ILA7ALhYQp_c6roNG
 xcbowemSwkzcx2zXlOFJ6o5QB0bBDVb0A2QtuqmOdJjfvgZeg450goFaz6lPtN0tHDlIoDiVoz2n
 oyl2_O3usODyV7Pgaa2SN3Jr_4CuEv1M_1QVMcHKfORvu8VQajThj0K3YepPrRPaPxRJzsjppCIg
 Jm45hOvqIwpbJZF6ixgbFG2vCrSEvyS2owgMBDnoifVeXbkpE1goqGPOIWCEIBSxyZU5Zf1azmIl
 7c5zU35I28X2V9JKnfR2TSePYWKl_EsdIT2TimCaUCKJIl1UIrRxZG4U2iaPsQMjwQsc11R4q3pL
 QoZ7mpdcagg6aUjHc3IFSZUc2IyvbKZ1_hnpQneEjLnrD2PJbM4HRnUhBE_ZQ.HbvuZaklz.bngx
 klqHK0GtLkH90EyBPocy6QhG9x70r6D4cdTuU_az8b25Nym6YqGXMn.rXPpOv8ONGzVCQE_zXk9Y
 6PucOTSPTfR9i5Xh7fc8wRwXPGQeE2zPx93lquob0.MhD07R_kON45QdKCMC_6PvwzssDFP2cnBt
 L0cK1tUNnEGm16F4urjp1DzFoK_zkzt7PrfVr5uPJvwHMVsFY0Kxhqks7hWQtGRrmkufGm0j6UL9
 puwklBxKRWtwwdZFusbhuqeHoIXeQVBXJPYmJ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 8 May 2020 15:27:30 +0000
Date:   Fri, 8 May 2020 15:27:29 +0000 (UTC)
From:   Barr Kummar Faso <barrkummarfaso@gmail.com>
Reply-To: wu.paymentofic@fastservice.com
Message-ID: <503273029.194580.1588951649225@mail.yahoo.com>
Subject: YOUR GIFT WESTERN UNION PAYMENT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <503273029.194580.1588951649225.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15902 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:76.0) Gecko/20100101 Firefox/76.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



ATTN;BENEFICIARY:





You are welcome to Western UNION office Burkina Faso.



Am Barr Kummar Faso by name, The new director of Western Union Foreign Oper=
ation.


I resumed work today and your daily transfer file was submitted as pending =
payment in our Western union Bank and after my verification, I called the f=
ormal Accountant Officer in-charge of your payment to find out the reason w=
hy they are delaying your daily transfer and he explained that you was unab=
le to activate your daily installment account fully.


However, I don't know your financial capability at this moment and it was t=
he reason why I decided to help in this matter just to make it easy for you=
 to start receiving your daily transfer because I know that when you receiv=
e the total sum $900.000.00 usd that you will definitely compensate me.



I don't want you to lose this fund at this stage after all your efforts. Mo=
st wise people prefer to use this medium western union money transfer now a=
s the best and reliable means of transfer,Kindly take control of yourself a=
nd leave everything to God because I know that from now on, you will be the=
 one to say that our lord is good, so I will advice you to send me your dir=
ect phone number your address,country,Pass port because I will text you the=
 MTCN through SMS and attach other information and send to you through your=
 email box, Sender name Sender=E2=80=99s address with including all documen=
ts involve in the transaction.


For this moment I will be very glad for your quick response by sending sum =
of $25.00 so that I will quickly do the needful and finalize everything wit=
hin 1:43pm our local time here, I am giving you every assurance that as soo=
n as I receive the $25.00 that I will activate your daily installment accou=
nt and proceed with your first transfer of $7,000.00 before 1:43pm our loca=
l time because I will close once its 6:30pm.


Contact person Barr Faso Kummar
contact Email: wu.paymentofic@fastservice.com



Be aware that all verification's and arrangement involve in this transfer h=
as being made in your favour. So I need your maximum co-operation to ensure=
 that strictest confidence is maintained to avoid any further delay.


Send the $25.00 through Western Union Money Transfer to below following inf=
ormation and get back to me with copy of the Western Union slip OK?


Receiver's Name...
Country.... Burkina Faso
Text Question..........Good
Answer.............News
Amount .......$25 USD
MTCN............


I felt pains after going through your payment file and found the reason why=
 you have not start receiving your fund from this department and ready to d=
o my utmost to make sure you receive it all OK?


Be rest assured that I will activate your daily installment account and pos=
t your first $7,000 USD for you to pick-up today as soon as we receive the =
fee from you.


Please do not hesitate to contact us again should you require additional in=
formation or call +226 74 43 41 61 for further urgent attention, as we are =
here to serve you the best.


Regard's
Barrister Kummar Faso
New Director Western Union Foreign Operation
Our:Code of conduct:1000%
